class TrucsController < ApplicationController
  before_action :set_truc, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trucs = Truc.all
    respond_with(@trucs)
  end

  def show
    respond_with(@truc)
  end

  def new
    @truc = Truc.new
    respond_with(@truc)
  end

  def edit
  end

  def create
    @truc = Truc.new(truc_params)
    @truc.save
    respond_with(@truc)
  end

  def update
    @truc.update(truc_params)
    respond_with(@truc)
  end

  def destroy
    @truc.destroy
    respond_with(@truc)
  end

  private
    def set_truc
      @truc = Truc.find(params[:id])
    end

    def truc_params
      params.require(:truc).permit(:name)
    end
end
