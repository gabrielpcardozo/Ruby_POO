require 'time'
require 'cpf_utils'

class Person
    attr_accessor :name, :age, :address, :cep, :house_number, :alive

    def initialize(name, age, address)
        @name = name
        @alive = true
        set_age(age)
        set_address(address)
    end
    
    def set_age(age)
    birth_date = Time.parse(age)
    current_date = Time.now
    difference_in_seconds = current_date - birth_date
    @age = (difference_in_seconds / (365.25 * 24 * 60 * 60)).floor
    end

    def set_address(address)
        parts = address.split(/,\s*/)
        @address = parts[0..-3].join(', ')
        @cep = parts[-1]
        @house_number = parts[-2]
    end
end

class Individual < Person #Pessoa Física
    attr_accessor :cpf, :last_name, :gender, :type

    def initialize(name, age, address, last_name, gender, type = "Pessoa Física")
        super(name, age, address)
        set_cpf()
        @last_name = last_name
        @gender = gender
        @type = type
    end
    
    def get_full_name
        @name +' ' + @last_name
    end

    def set_cpf()
        new_cpf = CpfUtils.cpf
        @cpf = new_cpf.to_cpf_format

    end
end

class Entity < Person #Pessoa Jurídica 
    attr_accessor :cnpj, :business_entities, :type

    def initialize(name, age, address,cnpj, business_entities, type="Pessoa Jurídica")
        super(name, age, address)
        set_cnpj()
        @business_entities = business_entities
        @type = type
    end

    def get_full_name
        @name + ' ' + @business_entities
    end

    def set_cnpj()
        new_cnpj = CnpjUtils.cnpj
        @cnpj = new_cnpj.to_cpf_format
    end

