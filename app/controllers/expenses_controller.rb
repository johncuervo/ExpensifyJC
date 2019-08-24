class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @tab = :expenses
    @categories = Category.all
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new (expense_params)
    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
     redirect_to expenses_path, notice: 'Gasto editado correctamente.'
    else
     render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: 'Gasto eliminado correctamente.'
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

    def expense_params
      params.require(:expense).permit(:date, :amount, :concept, :type_id, :category_id).merge(user: current_user)
    end

end
