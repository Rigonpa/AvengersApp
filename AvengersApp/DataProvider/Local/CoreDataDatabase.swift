//
//  CoreDataDatabase.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataDatabase: LocalDataProvider {

    // MARK: - Common
    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        return appDelegate.persistentContainer.viewContext
    }()
    
    func persist() {
        try? context.save()
    }

    // MARK: - Heroes persistance
    private var heroeEntity = "Heroe"
    
    func createHeroe() -> Heroe? {
        guard let entity = NSEntityDescription.entity(forEntityName: heroeEntity, in: context) else { return nil }
        return Heroe(entity: entity, insertInto: context)
    }
    
    func fetchHeroes() -> [Heroe]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: heroeEntity)
        let heroesData = try? context.fetch(fetchRequest) as? [Heroe]
        return heroesData
    }
    
    func deleteHeroe(with name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: heroeEntity)
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let heroeToDelete = try? context.fetch(fetchRequest)
        heroeToDelete?.forEach { context.delete($0) }
        
        try? context.save()
    }
    
    //MARK: - Combats persistance
    private var combatEntity = "Combat"
    
    func createCombat() -> Combat? {
        guard let entity = NSEntityDescription.entity(forEntityName: combatEntity, in: context) else { return nil }
        return Combat(entity: entity, insertInto: context)
    }
    
    func fetchCombats() -> [Combat]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: combatEntity)
        let combatsData = try? context.fetch(fetchRequest) as? [Combat]
        return combatsData
    }
    
    func deleteCombat(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: combatEntity)
        fetchRequest.predicate = NSPredicate(format: "combat_id = %i", id)
        let combatToDelete = try? context.fetch(fetchRequest)
        combatToDelete?.forEach{ context.delete($0)}
        
        try? context.save()
    }
    
    // MARK: - Villains persistance
    private var villainEntity = "Villain"
    
    func createVillain() -> Villain? {
        guard let entity = NSEntityDescription.entity(forEntityName: villainEntity, in: context) else { return nil}
        return Villain(entity: entity, insertInto: context)
    }
    
    func fetchVillains() -> [Villain]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: villainEntity)
        let villainsData = try? context.fetch(fetchRequest) as? [Villain]
        return villainsData
    }
    
    func deleteVillain(with name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: villainEntity)
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let villainToDelete = try? context.fetch(fetchRequest)
        villainToDelete?.forEach{ context.delete($0) }
        
        try? context.save()
    }
    
    // MARK: - Initial characters
    
    func provideInitialHeroesData() -> [Heroe]? {
        var initialHeroes: [Heroe] = []
        
        // Heroe 1 "America Captain"
        guard let heroe1 = createHeroe() else { return nil }
        heroe1.name = "America Captain"
        heroe1.profile_image = "img_heroe_america_captain"
        heroe1.character_story = "During WWII, the patriotic Steve Rogers was offered a place in the military's top operation: Rebirth. Injected with an experimental super-serum, Rogers emerged from the treatment with heightened endurance, strength, and reaction time. With extensive training and an indestructible Vibranium shield, Rogers soon became the country's ultimate weapon: CAPTAIN AMERICA! Though frozen in ice during a climactic battle toward the end of the war, Rogers was discovered and revived decades later. Now the living legend continues the war against evil in modern times as a member of The Avengers!"
        heroe1.power = 5
        initialHeroes.append(heroe1)
        
        // Heroe 2 "Black Panther"
        guard let heroe2 = createHeroe() else { return nil }
        heroe2.name = "Black Panther"
        heroe2.profile_image = "img_heroe_black_panther"
        heroe2.character_story = "Monarch of the secluded but technologically advanced African nation of Wakanda, King TChalla is the Black Panther; a sacred title that must be both inherited & earned by the current Wakandan ruler. Granted superhuman powers by ceremonially consuming a mystical heart-shaped herb, the Black Panther is responsible for defending his people, and the world, from any threats."
        heroe2.power = 4
        initialHeroes.append(heroe2)
        
        // Heroe 3 "Black Widow"
        guard let heroe3 = createHeroe() else { return nil }
        heroe3.name = "Black Widow"
        heroe3.profile_image = "img_heroe_black_widow"
        heroe3.character_story = "Natasha Romanoff is the super-spy known as the Black Widow! Trained extensively in the art of espionage and outfitted with state-of-the-art equipment, Black Widow's combat skills are virtually unmatched. One of S.H.I.E.L.D's most valuable agents, she has carried out numerous black-ops missions and has recently been assigned by Director Nick Fury to keep an eye on the Avengers."
        heroe3.power = 3
        initialHeroes.append(heroe3)
        
        // Heroe 4 "Doctor Strange"
        guard let heroe4 = createHeroe() else { return nil }
        heroe4.name = "Doctor Strange"
        heroe4.profile_image = "img_heroe_dr_strange"
        heroe4.character_story = "Distinguished neurosurgeon Doctor Stephen Strange's self-important worldview was shattered, along with his steady operating hands, in a fateful car accident. Desperate to heal his injuries and pride, Strange sought out a legendary safe known as the Ancient One, becoming a pupil of the mystic arts. Learning that his true worth had always come from within, Strange uncovered his full potential and was chosen to become the Sorcerer Supreme, the world's pre-eminent defender against the darkness that lurks beyond."
        heroe4.power = 2
        initialHeroes.append(heroe4)
        
        // Heroe 5 "Gamora"
        guard let heroe5 = createHeroe() else { return nil }
        heroe5.name = "Gamora"
        heroe5.profile_image = "img_heroe_gamora"
        heroe5.character_story = "Orphaned as a child when the rest of her species was annihilated, Gamora was found and raised by the tyrant Thanos, who conditioned her to become an unparalleled warrior. Weary of the acts she was forced to commit in her would-be father’s name, Gamora later broke free of her chains. Teaming up with Star-Lord and his motley crew, the “most dangerous woman in the galaxy” now seeks to redeem her past crimes, putting her unparalleled skills to use as a member of the Guardians of the Galaxy."
        heroe5.power = 1
        initialHeroes.append(heroe5)
        
        // Heroe 6 "Hulk"
        guard let heroe6 = createHeroe() else { return nil }
        heroe6.name = "Hulk"
        heroe6.profile_image = "img_heroe_hulk"
        heroe6.character_story = "A massive dose of gamma radiation transformed the brilliant but meek scientist Bruce Banner's DNA, awakening the hidden, adrenaline-fed hero in his genes... HULK! A hero of few words and incredible strength, the Hulk has long been pursued by those who want to use his immense power for their own purposes, or by those who thought the Jade Giant's anger was too dangerous to be controlled. Now, as a member of the Avengers, Hulk helps smash the unimaginable threats that no Hero could face alone, hoping to at least prove to the world that he is the strongest HERO there is!"
        heroe6.power = 5
        initialHeroes.append(heroe6)
        
        // Heroe 7 "Ironman"
        guard let heroe7 = createHeroe() else { return nil }
        heroe7.name = "Ironman"
        heroe7.profile_image = "img_heroe_ironman"
        heroe7.character_story = "When billionaire industrialist Tony Stark dons his sophisticated steel-mesh armor, he becomes a living high-tech weapon - the world's greatest fighting machine. Tony has primed his ultra modern creation for waging state of the art campaigns, attaining sonic flight, and defending the greater good! He is the Armored Avenger - driven by a heart that is part machine, but all hero! He is the INVINCIBLE IRON MAN!"
        heroe7.power = 4
        initialHeroes.append(heroe7)
        
        // Heroe 8 "Marvel Captain"
        guard let heroe8 = createHeroe() else { return nil }
        heroe8.name = "Marvel Captain"
        heroe8.profile_image = "img_heroe_marvel_captain"
        heroe8.character_story = "A bold leader who doesn't sugarcoat, Carol is guided by a strong sense of duty and honor. She initially assists the promising heroes on their mission to save the world, then finds she must continue to mentor them. Though Carol has a compassionate heart, it will take some time for her to show it; however, she still has the respect and admiration of the team, especially Kamala, Doreen and Rayshaun. Carol brings the heroes together as an official team and ensures they're prepared for the challenges ahead."
        heroe8.power = 3
        initialHeroes.append(heroe8)
        
        // Heroe 9 "Spiderman"
        guard let heroe9 = createHeroe() else { return nil }
        heroe9.name = "Spiderman"
        heroe9.profile_image = "img_heroe_spiderman"
        heroe9.character_story = "The bite from a radioactive spider granted Peter Parker amazing arachnid-like powers. After losing his beloved Uncle Ben to a burglar, grief- stricken Peter vowed to use his incredible abilities to protect his city as the Amazing Spider-Man. Peter’s trials taught him an invaluable lesson: with great power, there must also come great responsibility."
        heroe9.power = 2
        initialHeroes.append(heroe9)
        
        // Heroe 10 "Thor"
        guard let heroe10 = createHeroe() else { return nil }
        heroe10.name = "Thor"
        heroe10.profile_image = "img_heroe_thor"
        heroe10.character_story = "Nordic legend tells the tale of the son of Odin, the heir to the throne of Asgard - he is THOR, renowned as the mightiest hero of mythology! Thor's strength, endurance, and quest for battle are far greater than his Asgardian brethren. The mighty Thor wields an enchanted Uru hammer, Mjolnir, and is master of thunder and lightning."
        heroe10.power = 4
        initialHeroes.append(heroe10)

        return initialHeroes
    }
    
    func provideIntialVillainsData() -> [Villain]? {
        var initialVillains: [Villain] = []
        
        // Villain 1 "Yon Rogg"
        guard let villain1 = createVillain() else { return nil }
        villain1.name = "Yon Rogg"
        villain1.profile_image = "img_heroe_yon_rogg"
        villain1.character_story = "Yon-Rogg is a Kree Empire commander and leader of Starforce, with a devout loyalty to the Supreme Intelligence and the Kree ideologies. During the Kree-Skrull War, Yon-Rogg and Minn-Erva were dispatched to kill Mar-Vell on Planet C-53, seeking a Tesseract-powered energy core that she was developing. Yon-Rogg later took under his tutelage Vers, a United States Air Force pilot who absorbed the core's energy during its destruction. Years later, at the prospect of Kree victory, the Starforce had cornered the Skrull population, including Talos, to C-53. When Vers learned of her true origins on C-53, Yon-Rogg was authorized by Ronan the Accuser to capture her. After failing to wipe out the Skrull refugees and stealing back the Tesseract, Yon-Rogg was defeated by Vers and sent back to Hala with a warning to the Supreme Intelligence."
        villain1.power = 5
        initialVillains.append(villain1)
        
        // Villain 2 "Dormammu"
        guard let villain2 = createVillain() else { return nil }
        villain2.name = "Dormammu"
        villain2.profile_image = "img_villain_dormammu"
        villain2.character_story = "If the powerful Dormammu’s exact beginning has ever been recorded on Earth, it was either lost or remains undiscovered. But, suffice to say, the powerful being has ruled his native Dark Dimension for untold ages and is its complete master. Despite his dominion over his home, the evil entity still craves more power and has decided that only by conquering and subjugating all other realms, planes, and dimensions can he ever truly be sated in his desires. For reasons purely his own, Dormammu has set his eye on Earth’s plane as the most important to conquer, perhaps owing to its suffusion of magic and magic-wielders. At some point in Earth’s past, a tome—the Book of Cagliostro—was crafted to include a ritual to summon Dormammu, providing the means for humans to approach the powerful being and form a connection between Earth and the Dark Dimension. This is important because the presence of three magic Sanctums on the planet prevent Dormammu from invading himself, despite his immense abilities."
        villain2.power = 4
        initialVillains.append(villain2)
        
        // Villain 3 "Ego"
        guard let villain3 = createVillain() else { return nil }
        villain3.name = "Ego"
        villain3.profile_image = "img_villain_ego"
        villain3.character_story = "The specifics of Ego’s origins remain unclear to Ego even to him; he eventually came to understand himself floating through the void of space alone. Eventually, he developed the ability to manipulate matter and molecules which allowed him to travel the cosmos in search of other life and dwell with other species with his humanoid avatar that was an extension of his consciousness. Disappointed and unimpressed with what he found, he decided to implant seedlings in thousands of planets, capable of terraforming into extensions of himself, and mated with numerous sentient beings in hopes of children that would carry his genetic makeup needed to carry out the Expansion."
        villain3.power = 3
        initialVillains.append(villain3)
        
        // Villain 4
        guard let villain4 = createVillain() else { return nil }
        villain4.name = "Hela"
        villain4.profile_image = "img_villain_hela"
        villain4.character_story = "Hela, Odin's first born, served as Asgard’s Executioner and Goddess of Death, as her and her father made their way through the Nine Realms bringing death, destruction and conquest along for the ride. When Odin had a change of heart and wanted peace, he could not stop Hela's ambition and bloodlust; he imprisoned her. With Odin’s passing, his power over her waning, Hela freed herself from Hel to take what she sees as rightfully hers—first, Asgard, then all Nine Realms."
        villain4.power = 2
        initialVillains.append(villain4)
        
        // Villain 5 "Ivan Vanko"
        guard let villain5 = createVillain() else { return nil }
        villain5.name = "Ivan Vanko"
        villain5.profile_image = "img_villain_ivan_vanko"
        villain5.character_story = "World class physicist turned musclehead maniac. Vanko is the son of the Russian scientist who helped build the arc reactor technology that would lead to the Iron Man suit. But when Vanko’s father was deported thanks to accusations by the Stark family, his life fell apart. Ivan has vowed revenge on the Starks, specifically the one flying around the world in Iron Man armor."
        villain5.power = 1
        initialVillains.append(villain5)
        
        // Villain 6 "Red Skull"
        guard let villain6 = createVillain() else { return nil }
        villain6.name = "Red Skull"
        villain6.profile_image = "img_villain_johann_schmidt"
        villain6.character_story = "An imperfect version of the Super-Soldier Serum gave HYDRA mastermind Johann Schmidt enhanced strength but left his face horribly disfigured. He became known as the Red Skull and would have conquered the world if Captain America had not stopped him during World War II. After the war, he went into hiding and emerged recently in an attempt to regain his youth. The attempt failed, but the Skull now possesses a stolen suit of Iron Man's armor. This newly invigorated 'Iron Skull' has vowed to destroy the Avengers and conquer the world!"
        villain6.power = 5
        initialVillains.append(villain6)
        
        // Villain 7 "Malekith"
        guard let villain7 = createVillain() else { return nil }
        villain7.name = "Malekith"
        villain7.profile_image = "img_villain_malekith"
        villain7.character_story = "Centuries ago Malekith was born in the Dark Woods in miserable surroundings. From his birth on, he was different then his peers since his face was half light, half dark. His own mother had sold him to merchants for her own gain. Eventually, Malekith returned to his mother, now a grown Elf, and killed her. Malekith proved himself to be an enemy of both the humans of Earth and the gods of Asgard. Malekith's greatest weapon was the Casket of Ancient Winters, which contained mystical forces that could reproduce the overwhelming frigidity of another of the Nine Worlds, Niffleheim, the realm of ice. To prevent Malekith from releasing the contents of the casket, Eric Willis, a mortal man, stole the casket. Without the casket's power Malekith was unable to protect himself from the wrath of Odin, the All-Father, Ruler of Asgard. Odin banished Malekith to another dimension where he remained for centuries."
        villain7.power = 4
        initialVillains.append(villain7)
        
        // Villain 8 "Ronan"
        guard let villain8 = createVillain() else { return nil }
        villain8.name = "Ronan"
        villain8.profile_image = "img_villain_ronan"
        villain8.character_story = "Raised on the Kree homeworld, Hala, Ronan's fierce devotion and aptitude allowed him to rise to the exalted position of Supreme Accuser of the Kree Empire. However, his overly zealous lust for justice and draconian adherence to ancient traditions caused Ronan to be seen as a fanatic in the eyes of his people, leading he and the more progressive Kree to a divisive split. Setting out with an army of devoted followers, Ronan now seeks to pass judgment on all those he sees as heathens, and scour the galaxy of their presence."
        villain8.power = 3
        initialVillains.append(villain8)
        
        // Villain 9 "Thanos"
        guard let villain9 = createVillain() else { return nil }
        villain9.name = "Thanos"
        villain9.profile_image = "img_villain_thanos"
        villain9.character_story = "Thanos was born on Saturn's moon Titan as the son of Eternals A'lars and Sui-San; his brother is Eros of Titan. Thanos carries the Deviants gene, and as such, shares the physical appearance of the Eternals' cousin race. Shocked by his appearance and the belief that he would destroy all life in the universe, Sui-San attempted to kill him, but she was stopped by A'lars. During his school years, Thanos was a pacifist[11] and would only play with his brother Eros and pets. By adolescence, Thanos had become fascinated with nihilism and death, worshipping and eventually falling in love with the physical embodiment of death, Mistress Death.[12] As an adult, Thanos augmented his physical strength and powers through his superior scientific knowledge. He also attempted to create a new life for himself by siring many children as well as becoming a pirate. He finds no fulfillment in either until he is visited again by Mistress Death, for whom he murders his offspring and his pirate captain."
        villain9.power = 5
        initialVillains.append(villain9)
        
        // Villain 10 "Ultron"
        guard let villain10 = createVillain() else { return nil }
        villain10.name = "Ultron"
        villain10.profile_image = "img_villain_ultron"
        villain10.character_story = "The robotic creation known as Ultron was initially activated with the best of intentions, but its artificial intelligence evolved too quickly. The evil robot soon figured out that all of humanity and the Avengers in particular would stand in the way of its rise into robotic perfection. Because of this Ultron upgrades its highly advanced form constantly, adapting its near-limitless abilities to match its twisted desire for ever more power and total domination."
        villain10.power = 1
        initialVillains.append(villain10)

        return initialVillains
    }
}
