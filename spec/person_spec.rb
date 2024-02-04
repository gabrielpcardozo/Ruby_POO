require './person.rb'

RSpec.describe Person do
    describe '#Criar pessoa' do
        context 'Se for possivel cria pessoa com os seus tipos corretos' do
            it 'Retorna mensagem de sucesso' do
                person = Person.new("Gabriel", "Cardozo", "17/11/2000", "Estrada das taipas, 615, 02995145", "Masculino")
                expect(person.name).to eq ('Gabriel')
            end        
        end
    end
end
