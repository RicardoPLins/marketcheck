class SupermercadosController < ApplicationController
  before_action :set_supermercado, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /supermercados or /supermercados.json
  def index
    # @supermercados = Supermercado.all
    @supermercados = Supermercado.all.page(
      params[:page]
    ).per(2)
  end

  # GET /supermercados/1 or /supermercados/1.json
  def show
  end

  # GET /supermercados/new
  def new
    @supermercado = Supermercado.new
  end

  # GET /supermercados/1/edit
  def edit
  end

  # POST /supermercados or /supermercados.json
  def create
    @supermercado = Supermercado.new(supermercado_params)

    respond_to do |format|
      if @supermercado.save
        format.html { redirect_to supermercado_url(@supermercado), notice: "Supermercado was successfully created." }
        format.json { render :show, status: :created, location: @supermercado }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supermercado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supermercados/1 or /supermercados/1.json
  def update
    respond_to do |format|
      if @supermercado.update(supermercado_params)
        format.html { redirect_to supermercado_url(@supermercado), notice: "Supermercado was successfully updated." }
        format.json { render :show, status: :ok, location: @supermercado }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supermercado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supermercados/1 or /supermercados/1.json
  def destroy
    @supermercado.destroy!

    respond_to do |format|
      format.html { redirect_to supermercados_url, notice: "Supermercado was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supermercado
      @supermercado = Supermercado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supermercado_params
      params.require(:supermercado).permit(:nome, :endereco, :horario_de_funcionamento)
    end
end
