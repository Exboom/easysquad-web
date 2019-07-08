# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create([
                {
                    id: 1,
                    role: "Администратор"
                },
                {
                    id: 2,
                    role: "Владелец команды"
                },
                {
                    id: 3,
                    role: "Администратор команды"
                },
                {
                    id: 4,
                    role: "Игрок"
                }
            ]
)
Reason.create([
                  {
                      id: 1,
                      role: "Семья"
                  },
                  {
                      id: 2,
                      role: "Работа"
                  },
                  {
                      id: 3,
                      role: "Болезнь"
                  },
                  {
                      id: 4,
                      role: "Другое"
                  }
              ]
)
User.create([
                {
                    id: 1,
                    email: "admin@mail.ru",
                    password: "123456",
                    password_confirmation: "123456",
                    approved: true
                }
            ]
)
UserRole.create([
                {
                    user_id: 1,
                    role_id: 1
                }
            ]
)