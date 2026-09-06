local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Susie"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 1000
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 21
    -- Enemy defense (usually 0)
    self.defense = 32
    -- Enemy reward
    self.money = 3

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 21 DF 32\n* The girl, the dragon.\n* Doesn't seems so friendly now."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Susie looks at you with pure\nrage in her eyes.",
        "* The atmosfere fells tense.",
        "* Smells like wet chalk.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    -- Register act called "Smile"
    self:registerAct("Convince")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("X-Slash", "Double\nSlash", {"kris"}, 40)
end

function Dummy:onAct(battler, name)
    if name == "Convince" then
        -- Give the enemy 100% mercy
        self:addMercy(0)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = { 
            "Do [color:red]YOU[color:reset] think i will\nkeep believing to you?",
            "After what [color:red]YOU[color:reset] did?",
            "You [color:maroon]I D I O T[color:reset]."
        }
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You told Susie that your friendship was real.",
            "* Susie's DEF increased!"
        }

    elseif name == "X-Slash" then
        local x_slash = XSlashSpell(battler, self)
        x_slash.damage_callback = function()
            self:hurt(54, battler)
        end
        Game.battle:addChild(x_slash)
        end
    return super.onAct(self, battler, name)
end
return Dummy