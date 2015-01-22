class MathController < ApplicationController
  def operation
    @result
    @num1 = params[:num1].to_i
    @num2 = params[:num2].to_i
    case params[:operation]
    when 'plus'
      @result = @num1 + @num2
    when 'minus'
      @result = @num1 - @num2
    when 'times'
      @result = @num1 * @num2
    when 'dividedby'
      @result = @num1 / @num2
    when 'tothe'
      @result = @num1 ** @num2
    else
      @result = "Please use plus, minus, times, dividedby, or tothe as a valid operation."
    end
    render :json => "{result: '#{@result}'}"
  end
end
