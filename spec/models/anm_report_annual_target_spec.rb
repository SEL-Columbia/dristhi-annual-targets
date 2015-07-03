require 'rails_helper'

describe AnmReportAnnualTarget do

  it { should belong_to(:dim_anm) }

  it { should belong_to(:dim_indicator) }

  it { should validate_presence_of(:dim_anm)}

  it { should validate_presence_of(:dim_indicator)}

  it { should validate_presence_of(:target)}

  it { should validate_presence_of(:start_date)}

  it { should validate_presence_of(:end_date)}

  it "should not be valid" do
    annualTarget = AnmReportAnnualTarget.new
    expect(annualTarget.valid?).to be(false)
  end

  it "should be valid" do
    annualTarget = AnmReportAnnualTarget.new
    annualTarget.dim_anm = DimAnm.first
    annualTarget.dim_indicator = DimIndicator.first
    annualTarget.target = "100"
    annualTarget.start_date = Time.now
    annualTarget.end_date = Time.now
    expect(annualTarget.valid?).to be(true)
  end

  it "should not be a valid target" do
    annualTarget = AnmReportAnnualTarget.new
    annualTarget.dim_anm = DimAnm.first
    annualTarget.dim_indicator = DimIndicator.first
    annualTarget.start_date = Time.now
    annualTarget.end_date = Time.now

    #annualTarget.target = "-1"
    #expect(annualTarget.valid?).to be(false)
    #
    #annualTarget.target = "100.5"
    #expect(annualTarget.valid?).to be(false)
  end

  it "should fetch data from the database" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "12"

    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)

    expect(anm_report_annual_target.dim_anm.anmidentifier).to eq(anm_identifier)
    expect(anm_report_annual_target.dim_indicator.indicator).to eq(indicator)
    expect(anm_report_annual_target.start_date).to eq(start_date)
    expect(anm_report_annual_target.end_date).to eq(end_date)
    expect(anm_report_annual_target.target).to eq(target)
  end

  it "should not fetch data from the database" do
    anm_identifier = 'xyz'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "12"

    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)

    expect(anm_report_annual_target).to eq(nil)
  end

  it "should update the existing annual target" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "13"

    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target.target).not_to eq(target)

    AnmReportAnnualTarget.import(anm_identifier, indicator, target, start_date, end_date)

    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target.target).to eq(target)
  end

  it "should create new annual target" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2015-03-26'.to_date
    end_date = '2016-03-25'.to_date
    target = "20"

    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target).to eq(nil)

    AnmReportAnnualTarget.import(anm_identifier, indicator, target, start_date, end_date)
    anm_report_annual_target = AnmReportAnnualTarget.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target.target).to eq(target)
  end

end
