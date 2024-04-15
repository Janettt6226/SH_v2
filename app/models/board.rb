class Board < ApplicationRecord
  belongs_to :game
  validates :liberal_policies_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :fascist_policies_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }






  # VICTORY CONDITIONS
#   def victory(board)
#     hitler = board.game.players.find_by(role: "Hitler")
#     liberal_victory(board)
#     fascist_victory(board)
#   end
# private

#   def liberal_victory(board)
#     if board.liberal_policies_count == 5
#       return true
#     elsif hitler.killed?
#       return true
#     else
#       return false
#     end
#   end

#   def fascist_victory(board)
#     if board.fascist_policies_count == 6
#       return true
#     elsif hitler.chancellor? && board.fascist_policies_count > 3
#       return true
#     else
#       return false
#     end
#   end
end
