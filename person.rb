require 'time'
require 'date'

#Esse arquivo tem como objetivo criar um sistema de pessoas Física e pessoa Jurídica para a construção da base do projeto.

class Person
    @@count_person = 0
    attr_accessor :name, :last_name, :age, :alive, :address, :cep, :house_number, :gender, :born_age

        def initialize(name, last_name, born_age, address, gender)
        @@count_person += 1
        @name = name
        @last_name = last_name
        @gender = gender
        @alive = true
        @born_age = born_age
        set_age()
        set_address(address)
    end

    def self.total_count_person
        @@count_person
    end
    

    def full_name
        @name + ' ' + @last_name
    end


    def set_age
        # Lógica para calcular a idade usando @born_age (data de nascimento)
        current = Time.now
        born_age = Time.parse(@born_age)
        difference_in_seconds = current.to_i - born_age.to_i
        #puts difference_in_seconds
        @age = (difference_in_seconds / (365.25 * 24 * 60 * 60)).floor
    end


    def set_address(address)
        parts = address.split(/,\s*/)
        @address = parts[0..-3].join(', ')
        @cep = parts[-1]
        @house_number = parts[-2]
    end


    def birthday
        @age += 1
    end


    def display_person
        puts "Nome da intância: #{@name}, Nome completo: #{self.full_name}." 
        puts "Tenho #{self.age} anos."
        puts "Moro na rua: #{self.address}, número:#{self.house_number}, Cep:#{self.cep}"
    end
end