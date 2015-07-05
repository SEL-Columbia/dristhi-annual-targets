require 'rails_helper'

describe AnmReportAnnualTargetSp do

  it { should belong_to(:dim_service_provider) }

  it { should belong_to(:dim_indicator_sp) }

  it { should validate_presence_of(:dim_service_provider)}

  it { should validate_presence_of(:dim_indicator_sp)}

  it { should validate_presence_of(:target)}

  it { should validate_presence_of(:start_date)}

  it { should validate_presence_of(:end_date)}

  it "should not be valid" do
    annualTarget = AnmReportAnnualTargetSp.new
    expect(annualTarget.valid?).to be(false)
  end

  it "should be valid" do
    annualTarget = AnmReportAnnualTargetSp.new
    annualTarget.dim_service_provider = DimServiceProvider.first
    annualTarget.dim_indicator_sp = DimIndicatorSp.first
    annualTarget.target = "100"
    annualTarget.start_date = Time.now
    annualTarget.end_date = Time.now
    expect(annualTarget.valid?).to be(true)
  end

  it "should fetch data from the database" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "12"

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)

    expect(anm_report_annual_target_sp.dim_service_provider.dim_anm_sp.anmidentifier).to eq(anm_identifier)
    expect(anm_report_annual_target_sp.dim_indicator_sp.indicator).to eq(indicator)
    expect(anm_report_annual_target_sp.start_date).to eq(start_date)
    expect(anm_report_annual_target_sp.end_date).to eq(end_date)
    expect(anm_report_annual_target_sp.target).to eq(target)
  end

  it "should not fetch data from the database" do
    anm_identifier = 'xyz'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "12"

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)

    expect(anm_report_annual_target_sp).to eq(nil)
  end

  it "should update the existing annual target" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2012-03-26'.to_date
    end_date = '2013-03-25'.to_date
    target = "13"

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target_sp.target).not_to eq(target)

    AnmReportAnnualTargetSp.import(anm_identifier, indicator, target, start_date, end_date)

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target_sp.target).to eq(target)

    target = "20"
    AnmReportAnnualTargetSp.import(anm_identifier, indicator, target, start_date, end_date)

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target_sp.target).to eq(target)
  end

  it "should create new annual target" do
    anm_identifier = 'bhe1'
    indicator = 'OCP'
    start_date = '2015-03-26'.to_date
    end_date = '2016-03-25'.to_date
    target = "20"

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target_sp).to eq(nil)

    AnmReportAnnualTargetSp.import(anm_identifier, indicator, target, start_date, end_date)

    anm_report_annual_target_sp = AnmReportAnnualTargetSp.fetch(anm_identifier, indicator, start_date, end_date)
    expect(anm_report_annual_target_sp.target).to eq(target)
  end
end