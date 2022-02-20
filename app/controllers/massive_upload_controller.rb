require 'uri'
require 'date'

class MassiveUploadController < ApplicationController

    def upload_file
        
        # xlsx = Roo::Excelx.new(params[:uploaded_file])
        xlsx = Creek::Book.new params[:uploaded_file], with_headers: true, check_file_extension: true
        sheet = xlsx.sheets[0]
        arr_xlsx_validated = Array.new
        arr_xlsx_unvalidated = Array.new

        sheet.simple_rows.drop(1).each do |row|
            
            


            if (row['Póliza'] == nil || row['Póliza'] == "" || row['Póliza'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)

            elsif (row['ID afiliado'] == nil || row['ID afiliado'] == "" || row['ID afiliado'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Nombre Afiliado'] == nil || row['Nombre Afiliado'] == "" || row['Nombre Afiliado'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Telefono Afiliado'] == nil || row['Telefono Afiliado'] == "" || row['Telefono Afiliado'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Origen'] == nil || row['Origen'] == "" || row['Origen'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Destino'] == nil || row['Destino'] == "" || row['Destino'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Fecha de nacimiento'] == nil || row['Fecha de nacimiento'] == "" || row['Fecha de nacimiento'] == " ")  && row.length > 0
                row['Fecha de nacimiento'] = format_data(row['Fecha de nacimiento'])
                arr_xlsx_unvalidated.append(row)

            elsif (row['Sexo'] == nil || row['Sexo'] == "" || row['Sexo'] == " " || row['Sexo'].match(/[M?F?m?f]/)==nil ) && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Nombre Plan'] == nil || row['Nombre Plan'] == "" || row['Nombre Plan'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Fecha Emisión'] == nil || row['Fecha Emisión'] == "" || row['Fecha Emisión'] == " ")  && row.length > 0
                row['Fecha Emisión'] = format_data(row['Fecha Emisión'])
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Fecha Inicio'] == nil || row['Fecha Inicio'] == "" || row['Fecha Inicio'] == " ") && row.length > 0
                row['Fecha Inicio'] = format_data(row['Fecha Inicio'])
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Fecha Fin'] == nil || row['Fecha Fin'] == "" || row['Fecha Fin'] == " ") && row.length > 0
                row['Fecha Fin'] = format_data(row['Fecha Fin'])
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Edo. Póliza'] == nil || row['Edo. Póliza'] == "" || row['Edo. Póliza'] == " ") && row.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Edad'] == nil || row['Edad'] == "" || row['Edad'] == " ")  && row.keys.length > 0
                arr_xlsx_unvalidated.append(row)
                
            elsif (row['Email '] == nil || row['Email '] == "" || row['Email '] == " " || (row['Email '] =~ URI::MailTo::EMAIL_REGEXP) == nil) && row.length > 0
                arr_xlsx_unvalidated.append(row)
            else

                           
                if row.length > 0
                    
                    row['Fecha de nacimiento'] = format_data(row['Fecha de nacimiento'])
                    row['Fecha Emisión'] = format_data(row['Fecha Emisión'])
                    row['Fecha Inicio'] = format_data(row['Fecha Inicio'])
                    row['Fecha Fin'] = format_data(row['Fecha Fin'])
                    
                    #Phonelib.valid?(row['Telefono Afiliado']) -> validar
       
                    arr_xlsx_validated.append()
                end
            end



        end
 


        render json: {'validated':arr_xlsx_validated, 'unvalidated':arr_xlsx_unvalidated}
        # render json: arr_xlsx_validated
    end
    private

    def format_data(data)
        if (data.instance_of? String)
            if data.include?('/')
                data = Date.strptime(data, '%m/%d/%Y')
            elsif data.include?('-')
                data = Date.strptime(data, '%Y-%m-%d')
            elsif data.include?('.')
                data = Date.strptime(data, '%d.%m.%Y')
            end
        end
        return data
    end
end
