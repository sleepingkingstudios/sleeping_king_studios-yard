# SleepingKingStudios::Yard

Tooling for working with YARD documentation.

## Installation

Add the docs dependencies to your Gemfile:

```ruby
group :doc do
  gem 'jekyll', '~> 4.3'
  gem 'sleeping_king_studios-yard'
  gem 'webrick', '~> 1.8' # Use Webrick as local content server.
  gem 'yard', '~> 0.9',  require: false
end
```

You may also want to consider adding a [Jekyll theme](https://jekyllrb.com/docs/themes/#pick-up-a-theme) and/or a Markdown parser (Kramdown is recommended).

Generate or update your `tasks.thor` file:

```ruby
# frozen_string_literal: true

load 'sleeping_king_studios/yard/tasks.rb'
```

### Installation Script

Use the installation script to quickly install the Jekyll application:

```bash
bundle exec thor docs:install --name="Orichalcum" --description="A real gem." --repository="www.example.com"
```

You can also install a GitHub pages workflow to automatically deploy to GitHub Pages. Make sure that Pages is configured for your repository to deploy from a GitHub action.

```bash
bundle exec thor docs:install:workflow
```

### Manual Installation

Update your `.gitignore` file to ensure that the path to your documentation directory (default is `./docs`) is *not* ignored, but the `./docs/_site` and `./docs/.jekyll-cache` subdirectories are ignored.

#### Set Up Jekyll

Generate the documentation directory (default is `./docs`).

Generate the configuration file at `./docs/_config.yml`. This should set up the collections for rendering documentation. For other configuration, see the [Jekyll documentation](#https://jekyllrb.com/docs/configuration/).

```
---
collections:
  classes:
    output: false
  constants:
    output: false
  methods:
    output: false
  modules:
    output: false
  namespaces:
    output: false
```

#### Set Up Jekyll Files

Generate the root document at `./docs/index.md`. This should provide an overview for your project and link to the versions page.

```markdown
# My Project

My Project is documented using `SleepingKingStudios::Yard`.

For previous releases, see the [Versions]({{site.baseurl}}/versions) page.
```

Generate the `./docs/versions` directory and the `./docs/versions/index.md` document. This should provide an entry point for viewing documentation for published versions. This is also a good place to reference the `CHANGELOG` file from your repository.

```markdown
# Versions

For more information on release versions, see the [Changelog](https://github.com/).

- [Version 1.0]({{site.baseurl}}/versions/1.0)
```

Generate the `./docs/reference` directory and the `./docs/reference/index.md` document. This will display the generated documentation from your project.

```markdown
{% assign root_namespace = site.namespaces | where: "version", page.version | first %}

# My Project Reference

{% include reference/namespace.md label=false namespace=root_namespace %}
```

#### Set Up Jekyll Templates

Generate the `./docs/_includes` and `./docs/includes/reference` directories. The contents can be copied from an existing project.

> @todo: Generate templates. For now, the templates should be copied from an existing project.

#### Set Up Deployment

To deploy the generated documentation to GitHub Pages, navigate to the Settings page for your repository and select the Pages option (under `Code and automation`). Under the "Build and deployment" heading, update the "Source" dropdown to select "GitHub Actions". The workflow file can be copied from an existing project.

## Generating Documentation

Use the `Thor` CLI to generate documentation. The `docs:generate` task will create documentation for new files, while `docs:update` will also update existing file documentation.

## CLI Tasks

The gem defines a `Thor` CLI for generating documentation. To view the defined commands, run `bundle exec thor list`; all of the tasks for this gem are defined under the `docs:` namespace.

### docs:generate

The `docs:generate` task generates the documentation files for each Ruby file in your project. It does not update any existing files by default, so if you have made changes to existing code use the `docs:update` command (below) or use the `--force` command line option.

```bash
bundle exec thor docs:generate
```

The `docs:generate` command defines the following options:

docs_path
: The `--docs-path=value` option allows customizing the root directory for the generated documentation files. The default value is `./docs`.

dry_run
: If the `--dry-run` flag is set, the task will not make any changes to the filesystem.

force
: If the `--force` flag is set, the task will overwrite previously generated files.

verbose
: If the `--skip-verbose` flag is set, the task will not output its status to STDOUT.

version
: The `--version=value` option allows setting a version for the generated documentation. If set, the files will be generated in namespaced directories and set the `version` flag in the YAML files.

### docs:install

The `docs:install` task installs the Jekyll application.

```bash
bundle exec thor docs:install --name="Orichalcum" --description="A real gem." --repository="www.example.com"
```

The `docs:install` command defines the following options:

description
: The `--description=value` option allows for setting a description for the library. This is used when generating the template files.

docs_path
: The `--docs-path=value` option allows customizing the root directory for the generated documentation files. The default value is `./docs`.

dry_run
: If the `--dry-run` flag is set, the task will not make any changes to the filesystem.

name
: The `--name=value` option allows for setting a name for the library. This is used when generating the template files.

repository
: The `--repository=value` option allows for setting a repository URL for the library. This is used when generating the template files.

root_path
: The `--root-path=value` option allows setting the root directory for the library. It is used when updating the `.gitignore` file. The default value is the working directory.

verbose
: If the `--skip-verbose` flag is set, the task will not output its status to STDOUT.

### docs:install:templates

The `docs:install:templates` command installs or updates the Jekyll templates for YARD objects.

```bash
bundle exec thor docs:install:templates
```

The `docs:install` command defines the following options:

docs_path
: The `--docs-path=value` option allows customizing the root directory for the generated documentation files. The default value is `./docs`.

dry_run
: If the `--dry-run` flag is set, the task will not make any changes to the filesystem.

force
: If the `--force` flag is set, the task will overwrite any existing templates.

verbose
: If the `--skip-verbose` flag is set, the task will not output its status to STDOUT.

### docs:install:workflow

The `docs:install:workflow` command installs or updates the GitHub actions workflow for deploying to Pages.

```bash
bundle exec thor docs:install:workflow
```

The `docs:install:workflow` command defines the following options:

dry_run
: If the `--dry-run` flag is set, the task will not make any changes to the filesystem.

force
: If the `--force` flag is set, the task will overwrite an existing workflow.

root_path
: The `--root-path=value` option allows setting the root directory for the library. The default value is the working directory.

verbose
: If the `--skip-verbose` flag is set, the task will not output its status to STDOUT.

### docs:update

The `docs:update` task generates and updates the documentation files for each Ruby file in your project. It will update any existing documentation files.

```bash
bundle exec thor docs:update
```

The `docs:update` command defines the following options:

docs_path
: The `--docs-path=value` option allows customizing the root directory for the generated documentation files. The default value is `./docs`.

dry_run
: If the `--dry-run` flag is set, the task will not make any changes to the filesystem.

verbose
: If the `--skip-verbose` flag is set, the task will not output its status to STDOUT.

version
: The `--version=value` option allows setting a version for the generated documentation. If set, the files will be generated in namespaced directories and set the `version` flag in the YAML files.
