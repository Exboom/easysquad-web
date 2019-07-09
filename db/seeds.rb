# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.destroy_all
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
Reason.destroy_all
Reason.create([
                  {
                      id: 1,
                      reason: "Семья"
                  },
                  {
                      id: 2,
                      reason: "Работа"
                  },
                  {
                      id: 3,
                      reason: "Болезнь"
                  },
                  {
                      id: 4,
                      reason: "Другое"
                  }
              ]
)
User.destroy_all
user=User.new
user.email='admin@mail.ru'
user.password='123456'
user.encrypted_password='123456'
user.save!
user.update(approved: true)

UserRole.destroy_all
UserRole.new(user_id:user.id, role_id:1).save!