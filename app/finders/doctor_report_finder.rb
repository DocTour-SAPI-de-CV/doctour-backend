# frozen_string_literal: true

class DoctorReportFinder < ApplicationFinder
  def find(params)
    @start_date = params[:start_date].to_date.beginning_of_day
    @end_date = params[:end_date].to_date.end_of_day

    report_result
  end

  def report_result
    @report = Screening.where('created_at between (?) and (?)', @start_date, @end_date)
    return { result: 'nothing found on given date', status: 404 } if @report.empty?

    response = []

    @report.each do |result|
      response << {
        name: result.patient.person.full_name,
        age: age(result.patient.person.birthdate),
        gender: result.patient.person.gender,
        diagnostics: diagnostics(result)
      }
    end

    { result: response, status: 200 }
  end

  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - (now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1)
  end

  def diagnostics(result)
    soap = Soap.find_by(screening_id: result.id)
    diagnostics_soap = DiagnosticsSoap.where(soap_id: soap.id)

    diagnostics_soap.each do |diagnostic_soap|
      result = diagnostic_soap.diagnostic.name if diagnostic_soap.primary
    end
    result
  end
end
