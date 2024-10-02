class FavoritosChannel < ApplicationCable::Channel
  def subscribed
    stream_from "favoritos_channel"
  end

  def unsubscribed
    # Qualquer cleanup necessário quando o canal for desconectado
  end
end
