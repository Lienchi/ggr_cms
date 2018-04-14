class TabsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api 

  def create
    session["spreadsheet_id"] = params[:spreadsheet][:spreadsheet_url]
    session["tabs"] = []
    @service.get_spreadsheet(session["spreadsheet_id"], fields: "sheets.properties").sheets.each_with_index do |tab, index|
      session["tabs"] << { index: index, name: tab.properties.title } 
    end
  end
 
  def hide
    if params[:hide] == "hide"
      @hide =  "unhide"
    else
      @hide =  "hide"
    end  
    @tab_index = params[:tab_index]
    #render plain: @hide
  end


  # def dimension 
  #   @tab = Tab.find(params[:id])
  #   @tab.toggle!(:dimension)
  #   @spreadsheet = @tab.spreadsheet
  #   @tab.tags.clear
  #   if @tab.dimension
  #     range = ("A".."ZZ").to_a
  #     n = 0
  #     @service.get_spreadsheet_values(@spreadsheet.name, @tab.name ).values[0].each do |column|
  #       col = @tab.tags.build(tab_name: @tab.name, col: column, spreadsheet_id: @tab.spreadsheet.name, col_range: range[n], category_id: 1)
  #       col.save!
  #       n += 1
  #     end  
  #   else
  #     range = ("1".."1000").to_a
  #     n = 0
  #     @service.get_spreadsheet_values(@spreadsheet.name, @tab.name, major_dimension: "COLUMNS" ).values[0].each do |column|
  #       col = @tab.tags.build(tab_name: @tab.name, col: column, spreadsheet_id: @tab.spreadsheet.name, col_range: range[n], category_id: 1)
  #       col.save!
  #       n += 1
  #     end
  #   end

  #   redirect_to spreadsheet_path(@tab.spreadsheet)
  # end


  private

  def set_api
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = Rails.application.config_for(:api)["api_key"]
    @service.authorization = nil
  end

end
