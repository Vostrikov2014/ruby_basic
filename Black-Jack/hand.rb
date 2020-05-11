class Hand
  def initialize(game)
    @game = game
  end

  def user_winner
    if @game.user.score > @game.dealer.score && @game.user.score <= 21 || @game.dealer.score > 21 && @game.user.score <= 21
      @game.user.get_win(@game.bank_game)
      @game.user
    elsif @game.dealer.score > @game.user.score && @game.dealer.score <= 21 || @game.dealer.score <= 21 && @game.user.score > 21
      @game.dealer.get_win(@game.bank_game)
      @game.dealer
    else
      @game.user.get_win(@game.bank_game / 2)
      @game.dealer.get_win(@game.bank_game / 2)
      false
    end
  end
end