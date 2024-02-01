require_relative 'person'

class Individual < Person #Pessoa Física
    @@count_individual = 0
    attr_accessor :cpf, :type, :rg, :sector, :role, :company
#Cria uma pessoa Física. Foi uma forma de formalizar uma pessoa dentro desse "sistema", é como se fosse a criação dos documentos e aquisição de algumas novas funções.
    def initialize(name, last_name, age, address, gender, rg = nil, type = "Pessoa Física")
        super(name,last_name, age, address, gender)
        @@count_individual += 1
        @type = type
        @sector = nil
        @role = nil
        @company = "Não possui empresa aberta nesse CPF."
        set_cpf
        set_rg
    end

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
        if @alive && self.age > 18# Aqui por mais que nao seja uma verificao tao efetiva assim achei importante ter uma validacao.
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