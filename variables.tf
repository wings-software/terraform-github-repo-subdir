variable "repo_src" {
    type = "string"
    description = "Name of Source Repo, must be in form <GithubOrg>/<GithubRepo>"
}

variable "repo_dest" {
    type = "string"
    description = "Name of newly created github repo"
}

variable "repo_desc" {
    type = "string"
    description = "Description of newly created github repo"
}

variable "repo_dir" {
    type = "string"
    description = "Location to save repo on Local System"
}

variable "repo_branch" {
  default = "master"
}


variable "sub_dir" {
    type = "string"
    description = "Subdirectory containing desired repo content"
    default = false
}


variable "module" {
    default = false
    type = "string"
    description = "Is this a Terraform Module? if so, set to true"
}
