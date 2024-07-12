# Contributing Rules
These rules should be easy to follow. Please do not misuse the template for personal gain. 

## Adding Changes to Source Code
### Adding a File:
If you want to add a file, please do not add anything to `import.hx` for imports unless you are adding a lot of files that actually utilize that module/class

### Changes to files:
Changing the contents of the file shouldn't be a problem if it doesn't cause any major problems<br>
> [!NOTE]
> If you're using a class that is moved to another package or anything that can cause problems to the commonly used older versions, please do this fix. <br>
> For example: FlxSound was moved from `flixel.system` to `flixel.sound` on version 5.3.0. This can be fixed with a simple code
> ```hx
> #if (flixel < 5.3.0)
> import flixel.system.FlxSound;
> #else
> import flixel.sound.FlxSound;
> #end
> ```

> [!IMPORTANT]
> ### Major Change:
> When making a major change to the source code, contact me regarding the change first. Describe what's your goal and how it can make the template better.
>
> ### Linking the code to a external machine
> If you are to link a variable to a external website, your pull request will be likely rejected because a lot of things can happen. Your pull request is going to be 100% rejected if the variable to link contains the user's personal and sensitive information. 

### Fixing a bug:
When fixing a bug, make sure the fix doesn't cause *another* bug.
