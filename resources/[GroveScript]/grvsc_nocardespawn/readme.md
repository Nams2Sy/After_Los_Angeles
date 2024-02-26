## No Car Despawn

Introducing "**No-Car-Despawn**", a groundbreaking addition to **FiveM RP** that's changing the game. Tired of traditional garage scripts causing your vehicles to vanish? With this innovative solution, those worries are a thing of the past.

Imagine immersing yourself in RP scenarios, knowing your carefully customized vehicles won't disappear unexpectedly. **"No-Car-Despawn" ensures your vehicles stay exactly where you left them.** No more frustration, no more interruptions—just seamless RP enjoyment.

Unlike standard garage scripts, this innovation offers reliability and tranquility. Whether you're chasing adventures, embracing quests, or simply exploring, your vehicles remain faithfully by your side. This sense of security deepens your connection with the virtual world.

Beyond convenience, **"No-Car-Despawn"** encourages long-term planning, customizing, and **strategic utilization**. Whether you're a seasoned player or new to RP, this script elevates your experience.

In essence, "**No-Car-Despawn**" isn't just a script; it's your assurance of an enhanced FiveM RP journey. Wave goodbye to disappearing vehicles and say hello to a new era of stability. As you cruise through roleplay narratives, remember your vehicles are as steady as your passion for the game.

### The script includes all of the following:
- ESX based, editable for your framework
- Vehicles do not despawn
- No more garage scripts
- Possibility to use any car locking system
- Car damages are saved
- No lag ( 0.00 ms ) 


VIDEO: [No Car Despawn = YouTube](https://www.youtube.com/watch?v=q1NetfYOG9c)

Tebex ESCROW: [Buy DF No Car Despawn - Escrow ](https://dfscript.tebex.io/package/5524490)

Tebex SOURCE CODE: [Buy DF No Car Despawn - Source Code](https://dfscript.tebex.io/package/5524490)

|                                         |                                                  |
|-------------------------------------|----------------------------                |
| Code is accessible       | Yes / No                                          |
| Subscription-based      | No              |
| Lines (approximately)  | 700              |
| Requirements                | Database    |
| Support                           | Yes |

## Installation

Run the sql file

## Usage

To trigger the open / close car doors trigger the following export in your locking system:
```lua
exports['df_nocardespawn']:CarLocking(plate, bool)
```
where plate is the plate of your car and the bool is 1 o 0:
- 2 if the car is locked
- 1 if the car is unlocked

Remember to edit the `edit.lua` and the `editClient.lua` files if you aren't using ESX framework.

## Configuration

In the `serverConfig.lua` you can edit your plate column name.

## Help

If you have any problem with this script you can contact us on our [Discord](https://discord.gg/jmms83BVD8)