class TabsController < ApplicationController
  require 'google/apis/sheets_v4'
  before_action :set_api
 

  def create
    session["spreadsheet_id"] = params[:spreadsheet][:spreadsheet_url]
    session["tabs"] = []
    session["js"] = {}
    @service.get_spreadsheet(session["spreadsheet_id"], fields: "sheets.properties").sheets.each_with_index do |tab, index|
      session["tabs"] << { index: index, name: tab.properties.title, dimension: "ROWS" } 
      session["js"][index] = {}
    end

  end
 
  def hide
    @tab_index = params[:tab_index]
  end


  def dimension
    @tab_index = params[:tab_index]
    @columns = []
    if session["tabs"][@tab_index.to_i]["dimension"] == "ROWS"
      session["tabs"][@tab_index.to_i]["dimension"]  = "COLUMNS"
      range = ("1".."1000").to_a
      @service.get_spreadsheet_values(session["spreadsheet_id"], session["tabs"][@tab_index.to_i]["name"], major_dimension: "COLUMNS").values[0].each_with_index do |column, index|  
        @columns << { index: index, name: column, category_id: 1, xml_name: nil, tab_id: @tab_index, range: range[index] }
      puts "COLUMNS"
      end
    else
      session["tabs"][@tab_index.to_i]["dimension"]  = "ROWS"
      range = ("A".."ZZ").to_a
      @service.get_spreadsheet_values(session["spreadsheet_id"], session["tabs"][@tab_index.to_i]["name"]).values[0].each_with_index do |column, index|
        @columns << { index: index, name: column, category_id: 1, xml_name: nil, tab_id: @tab_index, range: range[index] }
      puts "ROWS"
      end
    end  
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
    @service.key = "AIzaSyCw1eTY-S9Xuxqv4AZ_bfHDlxEJ3KsLuig"
    @service.authorization = nil
  end
 
end
