module UserInfosConcern
    extend ActiveSupport::Concern

    included do
        has_many :subscriptions, dependent: :destroy
        has_many :messages, dependent: :destroy
        has_many :channels, through: :subscriptions
        has_many :users, through: :channels
        # belongs_to :last_channel, class_name: :Channel, foreign_key: "channel_id"

        # validates :alias, presence: true
        # validates :alias, uniqueness: true

        include PgSearch
        pg_search_scope :pgsearch,
          against: [:email, :alias],
          using: {  tsearch: { prefix: true, any_word: true },
                    dmetaphone: { any_word: true, sort_only: true },
                    trigram: { threshold: 0.3 }
                  },
          ignoring: :accents

        def alias
          "#{self.first_name} #{self.last_name}"
        end

        def friends
          users
          .uniq
          .select{ |user| user != self}
        end

        def self.selected_users(ids)
          where(id: ids)
          .reverse
        end

        def unread_messages_nbr(channel)
          subscription = Subscription.find_by(user: self, channel: channel)
          subscription.new_messages
          # diff > 0 ? diff : nil
        end

        def total_unread_messages_nbr
          subscriptions.reduce(0){|sum, s| sum + s.new_messages} #total = somme de 0 et nombre de messages non lus pour toutes les subscriptions
          # total > 0 ? total : 0
        end
    end
end
