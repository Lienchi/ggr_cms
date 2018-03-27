class SpreadsheetsController < ApplicationController
  def new
    @spreadsheet = Spreadsheet.new
  end
end
