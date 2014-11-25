appium_capybara strives to follow the [GitHub Ruby style guide](https://github.com/styleguide/ruby)


# Thor commands

```
$ thor list
default
-------
thor build          # Build a new gem
thor bump           # Bump the z version number and update the date.
thor bumpx          # Bump the x version number, set y & z to zero, update the date.
thor bumpy          # Bump the y version number, set z to zero, update the date.
thor byte           # Remove non-ascii bytes from all *.rb files in the current dir
thor docs           # Update docs
thor gem_install    # Install gem
thor gem_uninstall  # Uninstall gem
thor info           # prints config info for this gem
thor notes          # Update release notes
thor publish        # Build and release a new gem to rubygems.org
thor release        # Build and release a new gem to rubygems.org (same as publish)
```

To release use `thor bump` then `thor publish`
