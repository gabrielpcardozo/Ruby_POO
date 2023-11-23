require 'time'
require 'cpf_utils'
#A ideia desse arquivo é criar um sistema de pessoas Física e pessoa Jurídica para a construção da base do projeto.
class Person
    attr_accessor :name, :age, :rg, :alive

    def initialize(name, age, rg)
        @name = name
        @alive = true
        set_age(age)

    end

    def set_age(age)
    birth_date = Time.parse(age)
    current_date = Time.now
    difference_in_seconds = current_date - birth_date
    @age = (difference_in_seconds / (365.25 * 24 * 60 * 60)).floor
    end


end

class Individual < Person #Pessoa Física
    attr_accessor :cpf,:last_name, :gender, :type, :address, :cep, :house_number,
#Cria uma pessoa Física, basicamente coloca a pessoa dentro das leis.
    def initialize(name, age, address, last_name, gender, type = "Pessoa Física")
        super(name, age, address)
        set_cpf()
        @last_name = last_name
        @gender = gender
        @type = type
        set_address(address)

        end

=begin
Métodos
        Trabalhar
        Abrir uma empresa
        Abrir uma conta no Banco 
Atributos
        Nome e nome completo
        enderço e endereço completo 
        gênero
        idade
        Nome sujo ou limpo
=end
    
    def get_full_name
        @name +' '+ @last_name

    end

    def set_cpf()#Defini um CPF para uma pessoa 
        new_cpf = CpfUtils.cpf
        @cpf = new_cpf.to_cpf_format

    end

    def set_address(address)
        parts = address.split(/,\s*/)
        @address = parts[0..-3].join(', ')
        @cep = parts[-1]
        @house_number = parts[-2]

    end


end

class Entity < Person #Pessoa Jurídica 
    attr_accessor :cnpj, :business_entities, :type
#Cria uma pessoa Jurídica. Vou criar um sistema mais perto do real que eu conseguir.


    def initialize(name, age, address,cnpj, business_entities, type="Pessoa Jurídica")
        super(name, age, address)
        set_cnpj()
        @business_entities = business_entities
        @type = type

    end

=begin
Métodos
    Cria um CNPJ
    Contratar pessoas
    demitir pessoas
    pagar pessoas
    criar equipes dentro da empresa
    criar cargos dentro de equipes
    Verifica se o nome dos fundadores estão limpos
    Verifica se são maiores de idade

Atributos
    Nome juríridico da Empresa
    Nome fantasia 
    Descrição das atividades(Principais e secundárias)
    Código e descrição da natureza jurídica
=end

    def get_full_name
        @name + ' ' + @business_entities

    end

    def set_cnpj()
        new_cnpj = CnpjUtils.cnpj
        @cnpj = new_cnpj.to_cpf_format

    end

end
