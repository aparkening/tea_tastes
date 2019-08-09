#### Clear existing objects
User.delete_all
# Tea.delete
# Post.delete_all
Note.delete_all
Shop.delete_all


#### Users
users = [
  {name: "Jack Johnson", username: "c-george", password: "testing123", password_confirmation: "testing123"},
  {name: "Georgia Feather", username: "gfeather", password: "testing123", password_confirmation: "testing123"},
  {name: "Steven Bordle", username: "stebie", password: "testing123", password_confirmation: "testing123"}
]
user_objects = users.map { |item| User.create(item) }


#### Posts
dj_note = user_objects[0].notes.create(title: "Love this Darjeeling!", content: "<p>From the Shree Dwarika Tea Estate of Darjeeling India. Shree Dwarika means ”DOORWAY TO THE GODDESS”.</p><p>The first Spring harvest from the area of West Bengal Darjeeling situated by the northern frontier. An excellent tea before an important meeting.<p></p>A preponderance of tiny yellow-green uniformly rolled leaves over dark leaves and a strong “flowery” aroma. . This is a very fresh tea, especially if enjoyed in the late Spring just after harvest. This tea is incredibly flowery with mildly euphoric effects, virtually unrivaled in fragrance and texture. A sparkling, amber-orange color in the cup.</p>")

pu_note = user_objects[1].notes.create(title: "Pressed Pu-er FTW", content: "<p>Pu-Er tea pressed into the shape of a cake. A traditional present at engagements as the symbol of the family (due to its circular shape) and long life (Pu Er itself) in the southern Chinese province of Yunnan.</p>")

ab_note = user_objects[1].notes.create(title: "Ugh, too aged", content: "<p>This was marketed as an aged tea, and it definitely was! Song says:</p><p>This tea is a rare find. It is a baozhong oolong grown on Wenshan from a heritage cultivar that no longer exists today. This red-stemmed cultivar was eventually replaced by the more popular qing xin cultivar. The producer from whom we purchased had the foresight to set a small amount of the tea aside for aging in the 1960s. And for the next 50 years, the tea aged in ceramic urns.</p><p>Modern day baozhongs are light oxidized twisted oolongs, crafted in the manner of a Wuyi yancha, but light oxidized to preserve the tea’s innate aromatics. In the 1960s when this tea was crafted, baozhongs would have seen higher oxidation and longer roasting, producing notes of baked sugar and cream.</p><p>In the intervening years, the tea’s gradual aging has transformed it into something altogether different. Gradual oxidation produces the plum and mint notes, and mild fermentation also produces an earthiness akin to light sheng pu-erhs. The result is startlingly refreshing and delicious.</p>")

p_note = user_objects[1].notes.create(title: "How is Paris so good?!", content: "<p>A blend of three teas (and natural flavorings) that come together beautifully! Everyone who tries this tea buys it by the pound.</p>")

ph_note = user_objects[2].notes.create(title: "Yay, Phoenix Oolong", content: "<p>Smith says, 'Crafted by a family who has been making Phoenix Oolong for over 60 years, this tea is made using the Mi Lan Xiang (Honey Orchid Fragrance) cultivar which is one of the most well-known and for good reason. It makes for an exceptional tea with balanced fruit and floral notes. It is perfect for both the connoisseur or someone looking for an entry point into the world of Oolong tea and can be enjoyed in a traditional gaiwan or western teapot.'</p><p>And it is totally fruity! I love this tea any time of day.</p>")

d_note = user_objects[2].notes.create(title: "Light Dragonwell", content: "<p>Song says, 'White Dragonwell’s unusual name refers to this tea’s cultivar, which yields brilliant green leaves with a whitish down. It is closely related to a rare green tea called Anji Baicha (or Anji White Tea). The buds are small and boast wonderful fruit and floral notes.</p><p>What particularly distinguishes this tea is its source garden. At 1200m, the garden is in northern Zhejiang Province, less than an hour drive from Thousand Island Lake. It is remote, accessible via a single path that meanders through rows of loosely clustered tea plants. Limited infrastructure results in these plants being effectively dry-farmed. The region’s remoteness and elevation produce beautiful tea plants and perfect leaf buds.</p><p>This is the second year we’ve sourced White Dragonwell from this tea garden. The northerly latitude and higher elevation of this garden mean the harvest is later to sprout, and sprouts more sporadically than lower elevation gardens. Because of this, our method for selecting this tea is to cup several pickings - some earlier, and some later - and select the one that best combines the textural, aromatic, and taste properties that we look for in our teas. We are not necessarily tied to arbitrary date and time stamps, relying instead on the quality and character of the tea to guide our selection.</p><p>There are 30,000 buds in 500g of tea. Each batch was carefully roasted in 3 stages. First, the tea was fired to stop further enzymatic breakdown; it was then pressed and shaped, and finally pan-roasted to dry. The entire production process took 40 minutes to complete.</p><p>The finished result is sublime. To cup this tea is to experience a green that will reset your expectations of what quality is for a green tea. Its texture is incredible; luscious and viscous, while at the same time, delicate and bright.'</p>")


#### Shops
dobra_shop = Shop.create(name: "Dobra Tea", url: "https://www.dobratea.com", description: "<p>Dobrá Tea is a focus, a center; a space where balance is sought. A place which is always there to even out the impacts of external influences; cultural, social, communal, religious, international etc. and internal ones; peoples’ individuality, their spiritual leanings, moods etc.</p>")

smith_shop = Shop.create(name: "Smith Teamaker", url: "https://www.smithtea.com", description: "<p>Like a modern French restaurant, our raison d'être is to reinterpret classics with new life.</p><p>That means every blend begins with a moment of inspiration—maybe a nicely aged cask of merlot, or a scoop of ice cream—transformed by three essential ingredients.</p><p>Origin, craft and creativity.</p><p>As a Smith teamaker, you know — in the cup, it's all or nothing. You must have good tea, carefully handled, and made with imagination.</p>")

song_shop = Shop.create(name: "Song Tea and Ceramics", url: "https://songtea.com", description: "<p>We source rare tea and handcrafted ceramics of exceptional quality and character. We work directly with producers at origin.We source rare tea and handcrafted ceramics of exceptional quality and character. We work directly with producers at origin.</p><p>Each year, we assemble a collection of traditional, rare and experimental tea from China and Taiwan. We look for skillfully crafted leaves from clean growing regions – teas with structure, texture, and complexity. More importantly, every tea in the collection needs to be delicious.</p><p>Our ceramics come from Taiwan, China and the United States. We collaborate directly with artists, looking for pieces that show mastery of material and technique, and that echo our aesthetic. Each piece is beautiful to look at and wonderful to use.</p><p>Each year, we assemble a collection of traditional, rare and experimental tea from China and Taiwan. We look for skillfully crafted leaves from clean growing regions – teas with structure, texture, and complexity. More importantly, every tea in the collection needs to be delicious.</p><p>Our ceramics come from Taiwan, China and the United States. We collaborate directly with artists, looking for pieces that show mastery of material and technique, and that echo our aesthetic. Each piece is beautiful to look at and wonderful to use.</p>")

harney_shop = Shop.create(name: "Harney and Sons Fine Teas", url: "https://www.harney.com", description: "<p>Harney & Sons builds on a commitment to deliver customers the finest quality tea possible. This promise, made over 30 years ago, serves as the company's guiding principle. John's sons carry on the tradition. Today, Harney & Sons Tea remains family owned and managed, with three generations of Harneys preserving John's tradition of fine tea and traveling the world in search of the best ingredients.</p><p>It is not only the Harney mission to deliver quality tea products to their customers, but also to educate the world of tea history and taste. Whether through their dedicated customer service team, their published guides to tea drinking, or their two tea tasting shops, the Harney & Sons team works to pass on their passion for tea to a broad audience. Harney & Sons remains committed to delivering their customers a superior tea drinking experience.</p>")


#### Add Shops to Notes
dj_note.shops << dobra_shop
pu_note.shops << dobra_shop
ab_note.shops << song_shop
ph_note.shops << smith_shop
ph_note.shops << song_shop
d_note.shops << song_shop
p_note.shops << harney_shop