class CarrinhoAction
  ACTIONS = %w[create update remove].freeze

  attr_reader :action, :user_id, :cart_id, :item_id, :quantity

  def initialize(action, user_id, cart_id, item_id = nil, quantity = nil)
    raise ArgumentError, "Invalid action" unless ACTIONS.include?(action)

    @action = action
    @user_id = user_id
    @cart_id = cart_id
    @item_id = item_id
    @quantity = quantity
  end

  def to_h
    {
      action: action,
      user_id: user_id,
      cart_id: cart_id,
      item_id: item_id,
      quantity: quantity
    }
  end

  def to_json(*_args)
    to_h.to_json
  end
end
