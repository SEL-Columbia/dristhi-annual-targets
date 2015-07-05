require 'anm_report_annual_target'
require 'anm_report_annual_target_sp'

class TargetsController < ApplicationController
  def index
  end

  def import
    file = params[:file]
    @count = 0
    @error_records = []
    importFile(file)
  end

  def importFile(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      anm_identifier, end_date, indicator, start_date, target = sanitise(row)

      if ([anm_identifier, indicator, target, start_date, end_date].include?(nil))
        add_error_record(anm_identifier, indicator, target, start_date, end_date)
        next
      end

      unless AnmReportAnnualTarget.import(anm_identifier, indicator, target, start_date, end_date)
        add_error_record(anm_identifier, indicator, target, start_date, end_date)
        next
      end

      unless AnmReportAnnualTargetSp.import(anm_identifier, indicator, target, start_date, end_date)
        add_error_record(anm_identifier, indicator, target, start_date, end_date)
        next
      end
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then
        Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then
        Roo::Excel.new(file.path)
      when ".xlsx" then
        Roo::Excelx.new(file.path)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

  def sanitise(row)
    anm_identifier = row["ANM Identifier"]
    anm_identifier = anm_identifier.nil? ? nil : anm_identifier.strip

    indicator = row["Indicator"]
    indicator = indicator.nil? ? nil : indicator.strip

    target = row["Target"]
    target = target.nil? ? nil : row["Target"].to_int.to_s.strip

    start_date = row["start_date"]
    start_date = start_date.nil? ? nil : start_date

    end_date = row["end_date"]
    end_date = end_date.nil? ? nil : end_date
    return anm_identifier, end_date, indicator, start_date, target
  end

  def add_error_record(anm_identifier, indicator, target, start_date, end_date)
    error_record = Hash.new
    error_record[:indicator] = indicator
    error_record[:target] = target
    error_record[:start_date] = start_date
    error_record[:end_date] = end_date
    error_record[:anm_identifier] = anm_identifier
    @error_records.append(error_record)
    @count = @count + 1
  end
end
