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
      redirect_to root_path
    else
      render template: 'gifts/index'
    end
  end

  def my_gifts
    @gifts = current_user.gifts
  end

  # suggest a gift
  def suggest

    @context = params[:search][:context] rescue nil
    @recipient = params[:search][:recipient] rescue nil

    @gifts = Gift.any_in(author: current_user.friend_ids)
    unless current_user.gifts.any?
      flash[:info] = 'Raconte au moins un cadeau pour pouvoir voir ceux des autres !'
      redirect_to root_path
    end
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
    @gifts_count = Gift.count
  end

end
