class TabsController < ApplicationController
    before_action :set_api, only: [:dimension]
  def dimension 
    @tab = Tab.find(params[:id])
    @tab.toggle!(:dimension)
    @spreadsheet = @tab.spreadsheet
    @tab.tags.clear
    if @tab.dimension
      range = ("A".."ZZ").to_a
      n = 0
      @service.get_spreadsheet_values(@spreadsheet.name, @tab.name ).values[0].each do |column|
        col = @tab.tags.build(tab_name: @tab.name, col: column, spreadsheet_id: @tab.spreadsheet.name, col_range: range[n], category_id: 1)
        col.save!
        n += 1
      end  
    else
      range = ("1".."1000").to_a
      n = 0
      @service.get_spreadsheet_values(@spreadsheet.name, @tab.name, major_dimension: "COLUMNS" ).values[0].each do |column|
        col = @tab.tags.build(tab_name: @tab.name, col: column, spreadsheet_id: @tab.spreadsheet.name, col_range: range[n], category_id: 1)
        col.save!
        n += 1
      end
    end

    redirect_to spreadsheet_path(@tab.spreadsheet)
  end

  private
  def tab_params
    params.require(:tab).permit(:dimension)
  end
  def set_api
    require 'google/apis/sheets_v4'
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = 'AIzaSyCw1eTY-S9Xuxqv4AZ_bfHDlxEJ3KsLuig'
    @service.authorization = nil
  end

end
