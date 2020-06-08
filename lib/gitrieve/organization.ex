defmodule Gitrieve.Organization do
    defstruct org_name: nil, location: nil, public_repos: nil, url: nil

    use ExConstructor
end