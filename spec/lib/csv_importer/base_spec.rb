require 'rails_helper'

describe CsvImporter::Base do
  describe '.permitted_attributes' do
    subject { CsvImporter::Base }
    let(:filters) { [:a, :c, :e] }

    it '許可する属性を設定できること' do
      expect(subject.permitted_attributes).to eq []
      subject.permit_attributes(*filters)
      expect(subject.permitted_attributes).to eq filters
    end
  end

  describe '.redis_id' do
    subject { CsvImporter::Base }

    it 'Redis用のkeyに変換できること' do
      expect(subject.redis_id('hoge')).to eq 'csv_importer/base:hoge'
    end
  end

  describe '.exists?' do
    subject { CsvImporter::Base }

    it '存在する場合true, 存在しない場合falseを返すこと' do
      redis = Redis.current
      redis.set("#{subject.redis_id('aiueo')}:huga", 'hoge')
      expect(subject.exists?('aiueo')).to be true
      expect(subject.exists?('aueoi')).to be false
    end
  end

  describe '.model' do
    subject { CsvImporter::Base }

    it 'モデルクラスを設定できること' do
      subject.model('model')
      expect(subject.model_class).to eq 'model'
    end
  end

  describe '#valid?' do
    subject { CsvImporter::Base.new('hoge') }

    let(:valid) { instance_double(
        'CsvImporter::Model',
        valid?: true,
        errors: instance_double('ActiveModel::Errors', full_messages: [])
      ) }
    let(:invalid) { instance_double(
      'CsvImporter::Model',
      valid?: false,
      errors: instance_double('ActiveModel::Errors', full_messages: {column: 'hoge'})
      ) }

    before do
      allow_any_instance_of(CsvImporter::Base).to receive(:csv_open).with('hoge')
    end

    context 'ヘッダが正しく' do
      before do
        allow_any_instance_of(CsvImporter::Base).to receive(:valid_headers?).and_return(true)
      end

      it 'recordsが全てvalidのとき trueを返すこと' do
        subject.records = [valid, valid, valid]
        expect(subject).to be_valid
      end

      it 'recordsの一部がinvalidのとき falseを返すこと' do
        subject.records = [valid, valid, invalid]
        expect(subject).to_not be_valid
      end

      it 'recordsが全てinvalidのとき falseを返すこと' do
        subject.records = [invalid, invalid, invalid]
        expect(subject).to_not be_valid
      end
    end

    context 'ヘッダが不正で' do
      before do
        allow_any_instance_of(CsvImporter::Base).to receive(:valid_headers?).and_return(false)
      end

      it 'recordsが全てvalidのとき falseを返すこと' do
        subject.records = [valid, valid, valid]
        expect(subject).to_not be_valid
      end
    end

    describe '#execute' do
      subject { CsvImporter::Base.new('hoge') }

      before do
        allow_any_instance_of(CsvImporter::Base).to receive(:csv_open).with('hoge')
      end

      context '正常なレコードの場合' do
        before { expect(subject).to receive(:execute!) }

        it 'trueを返すこと' do
          expect(subject.execute).to eq true
        end
      end

      context '不正なレコードが含まれる場合' do
        before { expect(subject).to receive(:execute!).and_raise(StandardError) }

        it 'falseを返すこと' do
          expect(subject.execute).to eq false
        end
      end
    end
  end
end
