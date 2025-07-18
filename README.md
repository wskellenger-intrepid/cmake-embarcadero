# cmake-embarcadero
Fork of CMake 3.30 for RadStudio 12.x

This is not CMake source code!  These are Windows CMake binaries!

When you install CMake using GetIt, this is what you get.  
I copied the files from `Documents\Embarcadero\Studio\23.0\CatalogRepository\CMake-3.30` and made this repo with them.

The version GetIt installs is 3.30.2.

### Why did you create this repo?

1. If you want Embarcadero's version of CMake to pull as a submodule in your CI build(s), you can reference this repo.
2. If you find a bug in this version of CMake that involves Embarcadero's compiler, and you want to fix it, you can push it here for others to use.
3. Embarcadero was suppossed to push their changes to the official CMake repo, but it isn't clear if that has happened yet, since as of today 7/18/2025, this version 3.30 is still what Rad Studio's GetIt package manager installs.

### Notes
* I do not work for Embarcadero, and I will not act on bug reports from the public here.  You can report a bug though,
maybe someone else can fix it or help.
* If you make a pull request, I will accept and merge it if you fix a bug.

@wskellenger-intrepi


