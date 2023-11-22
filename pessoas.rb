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

class FisicPerson < Person
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
