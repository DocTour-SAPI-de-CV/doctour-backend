require 'uri'
require 'date'



CREATE = Register::CreateController
DELETE = Register::DeleteController
UPDATE = Register::UpdateController

class MassiveUploadController < ApplicationController
    
    def initialize
        @objects = {}
        @stop = false
    end

    def upload_file
        
        # xlsx = Roo::Excelx.new(params[:uploaded_file])
        xlsx = Creek::Book.new params[:uploaded_file], with_headers: true, check_file_extension: true
        sheet = xlsx.sheets[0]
        sheet_aux = xlsx.sheets[0]
        arr_xlsx_validated = Array.new
        arr_xlsx_unvalidated = Array.new
        arr_xlsx_updated = Array.new
        users_email = Array.new
        users_nacionality = Array.new
        

        sheet_aux.simple_rows.drop(1).each do |row|
            if row.length>0
                users_email.append(row['Email '])
                if row['Nacionalidad'].present?
                    users_nacionality.append(row['Nacionalidad'])
                    
                end
            end
        end

         

        nacionality_val = find_country(users_nacionality).pluck(:name).to_a
        # puts nacionality_val

        existent_user = User.where(email:users_email)
        existent_user_id = existent_user.pluck(:id)
        existent_user_email = existent_user.pluck(:email)

       
        

        sheet.simple_rows.drop(1).each do |row|
                 

            if row.length > 0

                if (row['Póliza'] == nil || row['Póliza'] == "" || row['Póliza'] == " ")
                    arr_xlsx_unvalidated.append(row)

                elsif (row['tipo documento'] == nil || row['tipo documento'] == "" || row['tipo documento'] == " ")
                    arr_xlsx_unvalidated.append(row)

                elsif (row['ID afiliado'] == nil || row['ID afiliado'] == "" || row['ID afiliado'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['primer nombre'] == nil || row['primer nombre'] == "" || row['primer nombre'] == " ")
                    arr_xlsx_unvalidated.append(row)

                elsif (row['ultimo nombre'] == nil || row['ultimo nombre'] == "" || row['ultimo nombre'] == " ")
                    arr_xlsx_unvalidated.append(row)

                elsif (row['Telefono Afiliado'] == nil || row['Telefono Afiliado'] == "" || row['Telefono Afiliado'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Origen'] == nil || row['Origen'] == "" || row['Origen'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Destino'] == nil || row['Destino'] == "" || row['Destino'] == " ") 
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Fecha de nacimiento'] == nil || row['Fecha de nacimiento'] == "" || row['Fecha de nacimiento'] == " ")
                    row['Fecha de nacimiento'] = format_data(row['Fecha de nacimiento'])
                    arr_xlsx_unvalidated.append(row)

                elsif (row['Sexo'] == nil || row['Sexo'] == "" || row['Sexo'] == " " || row['Sexo'].match(/[M?F?m?f]/)==nil )

                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Nombre Plan'] == nil || row['Nombre Plan'] == "" || row['Nombre Plan'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Fecha Emisión'] == nil || row['Fecha Emisión'] == "" || row['Fecha Emisión'] == " ")
                    row['Fecha Emisión'] = format_data(row['Fecha Emisión'])
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Fecha Inicio'] == nil || row['Fecha Inicio'] == "" || row['Fecha Inicio'] == " ")
                    row['Fecha Inicio'] = format_data(row['Fecha Inicio'])
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Fecha Fin'] == nil || row['Fecha Fin'] == "" || row['Fecha Fin'] == " ")
                    row['Fecha Fin'] = format_data(row['Fecha Fin'])
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Edo. Póliza'] == nil || row['Edo. Póliza'] == "" || row['Edo. Póliza'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Edad'] == nil || row['Edad'] == "" || row['Edad'] == " ")
                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['Email '] == nil || row['Email '] == "" || row['Email '] == " " || (row['Email '] =~ URI::MailTo::EMAIL_REGEXP) == nil)
                    arr_xlsx_unvalidated.append(row)

                elsif (row['Nacionalidad'] == nil || row['Nacionalidad'] == "" || row['Nacionalidad'] == " " || find_country([row['Nacionalidad']]).first == nil)

                    arr_xlsx_unvalidated.append(row)
                    
                elsif (row['idioma'] == nil || row['idioma'] == "" || row['idioma'] == " ")
                
                    arr_xlsx_unvalidated.append(row)

                else

                    nacionalidad = find_country([row['Nacionalidad']]).first
                    #puts nacionalidad

                    row['Fecha de nacimiento'] = format_data(row['Fecha de nacimiento'])
                    row['Fecha Emisión'] = format_data(row['Fecha Emisión'])
                    row['Fecha Inicio'] = format_data(row['Fecha Inicio'])
                    row['Fecha Fin'] = format_data(row['Fecha Fin'])
                    idiomas = Array.new
                    hash_idioma = find_language(row['idioma'].downcase)
                    #puts hash_idioma

                    idiomas.append({
                        id: hash_idioma.id,
                        name: hash_idioma.name,
                        native: TRUE,
                    })
                    #puts idiomas
                    nacionalidad_id = nacionalidad.id
                    
                    if row['Sexo'] == 'M' || row['Sexo'] == 'm'
                        row['Sexo'] = 'Male'
                    else
                        row['Sexo'] = 'Female'
                    end

                    
                    ali_baba = {
                        email: row['Email '],
                        password:  SecureRandom.alphanumeric(12),
                        document_type: row['tipo documento'],
                        id_afiliado: row['ID afiliado'],
                        phone: row['Telefono Afiliado'],
                        country_code: row['Codigo pais'].to_i,
                        area_code: row['Codigo area'].to_i,
                        primer_nombre: row['primer nombre'],
                        primer_apellido: row['ultimo nombre'],
                        fecha_nacimiento: format_data(row['Fecha de nacimiento']),
                        sexo: row['Sexo'],
                        nacionalidad_id: nacionalidad_id,
                        idiomas: idiomas,
                        plan_id: row['ID PLAN'].to_i,
                        checkIn: format_data(row['Fecha Inicio']),
                        checkOut: format_data(row['Fecha Fin'])
                        
                    }                    
                    
                    if existent_user_email.include?(row['Email '])

                        ret = update(ali_baba)
                        if ret.nil? == true
                            arr_xlsx_updated.append(ali_baba)
                        else
                            arr_xlsx_unvalidated.append(row)
                        end

                    else
                    
                        ret = create(ali_baba)

                        if ret.nil? == true
                            arr_xlsx_validated.append(ali_baba)
                        else
                            arr_xlsx_unvalidated.append(row)
                        end


                    end
                end
            end

           
        end


        render json: {'validated':arr_xlsx_validated, 'updated':arr_xlsx_updated ,'unvalidated':arr_xlsx_unvalidated}

    end

    
    def status_data_range
        
        validationDate = ValidationDate.where(user_id: params['user_id']).first()
        today = Date.today
        status = false
        checkOut = validationDate.checkOut
        checkIn = validationDate.checkIn

        if (validationDate.checkOut - today).to_i > 0
            status = true
        end

        render json: {'status':status, 'checkIn':checkIn ,'checkOut':checkOut}
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

    def create(data)
        person_data = {
              email: data[:email],
              password:  data[:password],
              document_type: data[:document_type], 
              # curp
              # dgp
              # passport
              # rfc
              
              document_number: data[:id_afiliado],
              # numero de documento de identidad
              
              country_code: data[:country_code],
              # codigo de pais
              
              area_code: data[:area_code],
              # codigo de area

              phone_number: data[:phone],
              # telefono
              
              first_name: data[:primer_nombre],
              # separado
              last_name: data[:primer_apellido],
              birthdate: data[:fecha_nacimiento],
              gneder: data[:sexo], 
              nationality_id: data[:nacionalidad_id],
              languages: data[:idiomas],
              plan_id: data[:plan_id],
              checkIn: data[:checkIn],
              checkOut: data[:checkOut]

              
            }
    
        # puts params
        
        unless @stop
          user = CREATE.user(person_data)
          result(user)
        end
        result(CREATE.account(@objects[:User], 'patient')) unless @stop
        result(CREATE.people(@objects[:Account], person_data)) unless @stop
        result(CREATE.document(person_data)) unless @stop
        result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
        result(CREATE.phone(person_data)) unless @stop
        result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop
        person_data[:languages].each do |language|
          result(CREATE.language(@objects[:People], language)) unless @stop
        end

        result(CREATE.patient(@objects[:People], request)) unless @stop
        result(CREATE.date_range(@objects[:User],person_data)) unless @stop
        

  
        unless @stop
          WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver
        end

        return @status
    end
    
    def update(data)

        
        unless @stop
            user = UPDATE.search_user(data)
            result(user)
        end

        person_data = {
            email: data[:email],
            password:  data[:password],
            document_type: data[:document_type], 
            # curp
            # dgp
            # passport
            # rfc
            
            document_number: data[:id_afiliado],
            # numero de documento de identidad
            
            country_code: data[:country_code],
            # codigo de pais
            
            area_code: data[:area_code],
            # codigo de area

            phone_number: data[:phone],
            # telefono
            
            first_name: data[:primer_nombre],
            # separado
            last_name: data[:primer_apellido],
            birthdate: data[:fecha_nacimiento],
            gneder: data[:sexo], 
            nationality_id: data[:nacionalidad_id],
            languages: data[:idiomas],
            plan_id: data[:plan_id],
            checkIn: data[:checkIn],
            checkOut: data[:checkOut]

            
        }

        result(UPDATE.date_range(@objects[:User], person_data)) unless @stop
  

        return @status
    end


    def result(content)
        if content[:object]
          hash = { "#{content[:object].class.name}": content[:object] }
          @objects.merge!(hash)
        end
  
        @message = content[:message]
        @status = content[:status]
  
        DELETE.objects(@objects) if content[:flag]
  
        @stop = true if content[:flag]
    end

    def find_language(language)
        
        return Language.find_by(name: language)
    end

    def find_country(nationality)
        nacionality_arr = Array.new
        nationality.each do |nac|
            nacionality_arr.append(nac.downcase)
        end

        return Nationality.where(name: nacionality_arr)
    end



end
