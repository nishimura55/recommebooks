class ChangeRecommeEvaluationPointDefaultOnBooks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :books, :recomme_evaluation_point, from: false, to: 0
  end
end
