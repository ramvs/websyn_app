Group.create(name: 'Ruby')
Group.create(name: 'Java')
Group.create(name: 'F#')
Group.create(name: 'Angular')
Group.create(name: 'C++"')

User.create(email: 'adam@test.pl', password: 'administrator1234', 
	groups: Group.where(name: ['Ruby', 'Java']))
User.create(email: 'michal@test.pl', password: 'administrator1234', 
	groups: Group.where(name: ['F#', 'Angular', 'C++']))
User.create(email: 'tomasz@test.pl', password: 'administrator1234', 
	groups: Group.where(name: ['Ruby', 'Java', 'F#', 'Angular', 'C++']))
User.create(email: 'mikolaj@test.pl', password: 'administrator1234')
