require 'anm_report_annual_target'

class TargetsController < ApplicationController
  def index
  end

  def import
    p params[:file]
    importFile(file)
  end

  def importFile(file)
    p file
    p file.path + "#####"
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      anm_identifier = row["ANM Identifier"]
      indicator = row["Indicator"]
      target = row["Target"]

      AnmReportAnnualTarget.import(anm_identifier, indicator, target, Time.now.to_date, Time.now.to_date)
      AnmReportAnnualTargetSp.import(anm_identifier, indicator, target, Time.now.to_date, Time.now.to_date)
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then
        Csv.new(file.path, nil, :ignore)
      when ".xls" then
        Excel.new(file.path, nil, :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end
end
