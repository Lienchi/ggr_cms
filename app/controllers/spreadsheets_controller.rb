class SpreadsheetsController < ApplicationController
  before_action :set_api, only: [:create, :js]
  before_action :set_spreadsheet, only: [:show, :js]
  
  def new
    @spreadsheet = Spreadsheet.new
  end

  def create
    @spreadsheet = Spreadsheet.new(spreadsheet_params)
    @spreadsheet.name =  @spreadsheet.name.split('/')[5]
    tabs = @service.get_spreadsheet(@spreadsheet.name, fields: "sheets.properties").sheets
    #save tabs 
    tabs.each do |tab|
      tab  = @spreadsheet.tabs.build(name: tab.properties.title)
      tab.save
      #save tags
      range = ("A".."ZZ").to_a
      n = 0
      @service.get_spreadsheet_values(@spreadsheet.name, tab.name).values[0].each do |column|
        col = tab.tags.build(tab_name: tab.name, col: column, spreadsheet_id: tab.spreadsheet.name, col_range: range[n], category_id: 1)
        col.save!
        n += 1
      end
    end

    if @spreadsheet.save
      redirect_to spreadsheet_path(@spreadsheet)
    else
      #add restriction for unvailid url 
      render :new
    end
  end
 
  def show
    @tabs = @spreadsheet.tabs
  end

  def js
    #  @spreadsheed.name,有所有tags.col的陣列,有所有tags.name的陣列
    output_arr = []
    @col_arr = []
    @name_arr = []
    @category_arr = []
    @spreadsheet.tabs.each do |tab|
      tab.tags.each do |tag|
        unless tag.name.blank?
          output_arr << tag
        end  
      end 
    end
    output_arr.each do |x|
      @col_arr << x.tab.name + "!" + x.col_range+":"+ x.col_range
      @name_arr << x.name
      @category_arr << x.category_id
    end
  end

  private

  def set_api
    require 'google/apis/sheets_v4'
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.key = 'AIzaSyCw1eTY-S9Xuxqv4AZ_bfHDlxEJ3KsLuig'
    @service.authorization = nil
  end

  def set_spreadsheet
    @spreadsheet = Spreadsheet.find(params[:id])    
  end

  def spreadsheet_params
    params.require(:spreadsheet).permit(:name)
  end

end
