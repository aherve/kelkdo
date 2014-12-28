class GiftsController < ApplicationController

  respond_to :html
  before_action :count_gifts, :get_name
  before_action :authenticate_user!

  def index
    @gift = Gift.new(author: current_user)

  end

  def create
    @gift = Gift.new(gift_params)
    @gift.author = current_user
    if @gift.save
      flash[:success] = "Génial !"
      redirect_to root_path
    else
      render template: 'gifts/index'
    end
  end

  def my_gifts
    @gift = Gift.new(author: current_user)
    flash[:info] = "T'as encore rien mis, patate !" if @my_gifts_count == 0
    @context = params[:search][:context] rescue nil
    @recipient = params[:search][:recipient] rescue nil

    @gifts = current_user.gifts

    @gifts = @gifts.where(context: @context) unless @context.blank?
    @gifts = @gifts.where(recipient: @recipient) unless @recipient.blank?
  end

  # suggest a gift
  def suggest

    unless @my_gifts_count > 0
      flash[:info] = 'Participe au moins une fois pour voir les idées des autres !'
      redirect_to root_path
    end

    @context = params[:search][:context] rescue nil
    @recipient = params[:search][:recipient] rescue nil

    @gifts = Gift.any_in(author: current_user.friend_ids)
    @gifts = @gifts.where(context: @context) unless @context.blank?
    @gifts = @gifts.where(recipient: @recipient) unless @recipient.blank?

    if @gifts.any?
      @gifts = @gifts.group_by(&:name)
      .map{ |k,v|
        {k => v.map(&:author).map(&:name).uniq}
      }
      .reduce(&:merge)
      .sort_by{|k,v| [-v.size, k]}
      .to_h
    end
  end

  private

  def gift_params
    params.require(:gift).permit(:name, :recipient, :context)
  end

  def get_name
    @name = if user_signed_in?
              current_user.name
            else
              'Vaillant(e) inconnu(e)'
            end
  end

  def count_gifts
    @my_gifts_count = current_user.gifts.count rescue 0
    @gifts_count = Gift.count
  end

end
