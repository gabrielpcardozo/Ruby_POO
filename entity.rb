require_relative 'person'
require 'cnpj_utils'
require 'time'
require 'date'


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
        @company_structure = {:Funcionarios => [],:Times => {}}#@company_structure = {"Team":[{"cargo":"Analista1"},{"Colaborador":class.object}]}
        set_cnpj
    end


    def self.count_entity#Simples contador de empresas abertas
        puts @@count_entity
    end


    def set_cnpj #Defini um cpnpj para uma empresa
        new_cnpj = CnpjUtils.cnpj
        @cnpj = new_cnpj.to_cnpj_format
    end


    def get_full_name#Entrega o nome completo de uma empresa juntando as variaveis nome e busines_entities
        @name + ' ' + @business_entities
    end
    
    #Aqui vou trabalhar com o @company_structure sendo assim possibilitanto criar a estrutura de colaboradores de uma empresa.
    def hire_employee(employee)
        if employee.alive && employee.age > 18 && employee.is_a?(Person)
            @company_structure[:Funcionarios] << employee
            puts "Adicionando novo colaborador..."
            puts "Colaborador adicionado!"
        end
    end


    def dismiss_employee(employee)
        for employee in @company_structure[:Funcionarios]
            @company_structure[:Funcionarios].delete(employee)
            puts @company_structure
        end
    end
    # Aqui eu preciso criar algo que funcione um pouco melhor fazer algum tipo de link entre
    #Colaborador - Equipe -  time, onde ao mesmo tempo que for adicionado um colaborador novo ele já venha com sua equipe e cargo.
    def create_team(team_name)#Cria uma chave dentro da estrutura da empresa. 
        @company_structure[team_name] = []
      end
    
      def set_role(team_name, role, employee)
        create_team(team_name) unless @company_structure.key?(team_name)
        @company_structure[team_name] << {"Role": role}
        @company_structure[team_name] << {"employee": employee}
    end
end