To Do

Add guided_prayers resource and implement ajax navigation of show pages

Schema:
Bible Prayers
	- Title: The Lord’s Prayer
	- Verse: Matthew 6:9–13
	- Summary: This prayer is the true classic. Most of us have said this prayer and could likely recite it right now. But there’s much more to this model that Jesus gave us than rote recitation. This is a prayer with real power: God’s kingdom coming, God’s will being done, all that we need for the day. It’s truly power packed.
	- Content: “Our Father in heaven,
hallowed be your name.
Your kingdom come,
your will be done,
on earth as it is in heaven.
Give us this day our daily bread,
and forgive us our debts,
as we also have forgiven our debtors.
And lead us not into temptation,
but deliver us from evil.”


Serializer





------------------------------

Model Associations

	User
		Has many prayers, fk author_id
		has many user_groups
		has many groups through user_groups
		has many lead groups
		Has many comments
		Has many commented_prayers(prayers), through comments
	
	Prayer
		Has many group_prayers
		Has many groups, through group_prayers
		Has many Comments
		Has many Commenters(users), through comments
		Belongs to Author

	Groups
		Has many user_groups
		Has many members, through user_groups (source = group_member)
		Has many group_prayers
		Has_many prayers, through group_prayers
		Belongs to leader(user)

	UserGroup
		Belongs to Group_member (user)
		Belongs to Group

	GroupPrayer
		Belongs to Group
		Belongs to Prayer
	
	Comments
		Belongs to Commentor (user)
		Belongs to Commented_Prayer (prayer)