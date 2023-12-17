require 'time'
require 'cpf_utils'
require 'cnpj_utils'
require 'date'
#A ideia desse arquivo é criar um sistema de pessoas Física e pessoa Jurídica para a construção da base do projeto.

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

=begin
Métodos 
    Ficar maios velho -> Só fazer de uma forma que a pessoa fique mais velha.
        As idades vão ser importantes para as interacoes com um ampresa
atributos
    Nome
    idade
    rg
    satatus -> Vivo ou morto
=end
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

class Individual < Person #Pessoa Física
    @@count_individual = 0
    attr_accessor :cpf, :type, :rg, :sector, :role, :company
#Cria uma pessoa Física, basicamente formaliza a pessoa criada como um cidadão.
    def initialize(name, last_name, age, address, gender, rg = nil, type = "Pessoa Física")
        super(name,last_name, age, address, gender)
        @@count_individual += 1
        @type = type
        @sector = nil
        @role = nil
        @company = "Não possui empresa aberta nesse CPF."#EU vou ter que mudar isso aqui para algo global para dentro da classe pessoa juridica conseguir alcançar, se é que já não é.
        set_cpf
        set_rg
    end

=begin
Métodos
    Cria um CPF -> def set_cpf
        Função que utiliza a gem do jackson pires
    Procurar um emprego -> def Choose_job
        Vai somente ter uma AREA e um CARGO como escolha para empresa contratar.
    Trabalhar -> def working? 
        Vai trabalhar na area e ter um status de empregado
    Abrir uma empresa
        Vai poder abrir uma empresa
    Abrir uma conta no Banco
        Quero fazer exclusivamente uma empresa seja um banco, onde o banco vai contratar pessoas e ainda funcionar como um banco. 
Atributos
        Nome e nome completo
        enderço e endereço completo 
        gênero
        idade
        Nome sujo ou limpo
=end

    def self.total_count_individual
        @@count_individual
    end
    
    def object
        self
    end

    def set_cpf #Defini um CPF para uma pessoa 
        new_cpf = CpfUtils.cpf
        @cpf = new_cpf.to_cpf_format
    
    end
    

    def set_rg
        @rg = ''
        9.times { @rg += rand(10).to_s }
        @rg = @rg[0..1] + '.' +
         @rg[2..4] + '.' + @rg[5..7] + '-' + rand(10).to_s + rand(10).to_s
        @rg
    end


    def choose_job(sector = nil, role = nil)
        puts "Qual o seu setor desejado?"
        @sector = gets.chomp    
        puts "Qual o seu cargo de preferência?"
        @role = gets.chomp
    #Quando eu chemei essa funcao ela deu um comportamento novo, ele simplesmente impriminha o meu ultimo valor definido nao faco a menor ideia o do pq. 
    #Para resovler eu so chamei a funcao sem o PUTS para ter uma chamada mais direta.
    end


    def working?
        if self.role.nil? || self.company.nil?
            "Informações insuficientes para estar trabalhando."
        else
            "Trabalhando com #{self.role}, na #{@company}."
        end
    end

    def open_company(name, address, business_entities, born_age, description)
        #name, address, business_entities, born_age, description = " ",type = "Pessoa Jurídica"
        if @alive && self.age > 18
          puts "Approve"
          puts "Estamos dando andamento na papelada."
          @company = Entity.new(name, address, business_entities, born_age, description)
          return @company = company
        else
          puts "Not approve"
          return nil  # ou qualquer valor de retorno adequado
        end
      end


    def display_individual
        puts "Nome da intância: #{self.name}, Nome completo: #{@full_name}." 
        puts "Tenho #{self.age} anos, gênero:#{self.gender}."
        puts "Informações pessoais, CPF:#{self.cpf}, RG:#{self.rg}, Tipo:#{self.type}."
        puts "Moro na rua: #{self.address}, número:#{self.house_number}, Cep:#{self.cep}"
    end


end

class Entity < Person#Pessoa Jurídica
    @@count_entity = 0
    attr_accessor :name, :cnpj, :business_entities, :type, :age, :description, :born_age, :company_structure

    #Cria uma pessoa Jurídica. Vou criar um sistema mais perto do real que eu conseguir.
    def initialize(name, address, business_entities, born_age, description = " ", type = "Pessoa Jurídica")
        super(name, last_name = business_entities, born_age, address, gender="Não necessário")
        @@count_entity += 1
        @name = name
        @business_entities = business_entities
        @type = type
        @description = " "
        @born_age = born_age
        @company_structure = {}#@company_structure = {"Team":[{"cargo":"Analista1"},{"Colaborador":class.object}]}
        set_cnpj
    end

=begin
Métodos
    Cria um CNPJ -> set_cnpj
        Função que utiliza a gem do jackson pires
    Criar uma empresa -> set_company
    Contratar pessoas
    Demitir pessoas
    Pagar pessoas
    Criar equipes dentro da empresa
    Criar cargos dentro de equipes
Atributos
    Nome juríridico da Empresa
    Nome fantasia 
    Descrição das atividades(Principais e secundárias)
    Código e descrição da natureza jurídica
=end

    def self.count_entity
        puts @@count_entity
    end


    def set_cnpj
        new_cnpj = CnpjUtils.cnpj
        @cnpj = new_cnpj.to_cnpj_format
    end


    def get_full_name
        @name + ' ' + @business_entities
    end
    
    def create_team(team_name)
        @company_structure[team_name] = []
      end
    
      def set_role(team_name, role, employee)
        create_team(team_name) unless @company_structure.key?(team_name)
        @company_structure[team_name] << {"Role": role}
        @company_structure[team_name] << {"employee": employee}
    end
end