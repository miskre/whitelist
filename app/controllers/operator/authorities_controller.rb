# class Operator::AuthoritiesController < Operator::BaseController
#   before_action :set_operator_authority, only: [:show, :edit, :update, :destroy]

#   # GET /operator/authorities
#   # GET /operator/authorities.json
#   def index
#     @operator_authorities = Operator::Authority.all
#   end

#   # GET /operator/authorities/1
#   # GET /operator/authorities/1.json
#   def show
#   end

#   # GET /operator/authorities/new
#   def new
#     @operator_authority = Operator::Authority.new
#   end

#   # GET /operator/authorities/1/edit
#   def edit
#   end

#   # POST /operator/authorities
#   # POST /operator/authorities.json
#   def create
#     @operator_authority = Operator::Authority.new(operator_authority_params)

#     respond_to do |format|
#       if @operator_authority.save
#         format.html { redirect_to @operator_authority, flash: {success: 'Authority was successfully created.'}}
#         format.json { render :show, status: :created, location: @operator_authority }
#       else
#         format.html { render :new }
#         format.json { render json: @operator_authority.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /operator/authorities/1
#   # PATCH/PUT /operator/authorities/1.json
#   def update
#     respond_to do |format|
#       if @operator_authority.update(operator_authority_params)
#         format.html { redirect_to @operator_authority, flash: {success: 'Authority was successfully updated.'}}
#         format.json { render :show, status: :ok, location: @operator_authority }
#       else
#         format.html { render :edit }
#         format.json { render json: @operator_authority.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /operator/authorities/1
#   # DELETE /operator/authorities/1.json
#   def destroy
#     @operator_authority.destroy
#     respond_to do |format|
#       format.html { redirect_to operator_authorities_url, flash: {success: 'Authority was successfully destroyed.'}}
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_operator_authority
#       @operator_authority = Operator::Authority.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def operator_authority_params
#       params.require(:operator_authority).permit(:level, :summary)
#     end
# end
