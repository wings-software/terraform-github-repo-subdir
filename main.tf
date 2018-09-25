provider "github" {}

data "github_repository" "repo_src" {
  full_name = "${var.repo_src}"
}

resource "github_repository" "repo_dest" {
  name        = "${var.repo_dest}"
  description = "${var.repo_desc}"
  gitignore_template = "Terraform"
  private = false
}

data "template_file" "gitsetup" {
  template = "${file("${path.module}/templates/git_setup.sh")}"
  vars {
    src_clone_url = "${data.github_repository.repo_src.ssh_clone_url}"
    ssh_clone_url = "${github_repository.repo_dest.ssh_clone_url}"
    repo_dir = "${var.repo_dir}"
    repo_branch = "${var.repo_branch}"
    sub_dir = "${var.sub_dir}"
  }
}

resource "local_file" "gitsetup" {
    content     = "${data.template_file.gitsetup.rendered}"
    filename = "${path.module}/gitsetup.sh"
}

resource "null_resource" "repo_setup" {
  depends_on = [
    "local_file.gitsetup"
  ]

  provisioner "local-exec" {
    command = "bash ${path.module}/gitsetup.sh"
  }
}

resource "null_resource" "tag_release" {
  count = "${var.module ? 1 : 0}"
  depends_on = [
    "null_resource.repo_setup"
  ]
  triggers = {
    push_trigger = "${github_repository.repo_dest.name}"
  }
  provisioner "local-exec" {
    command = "cd ${var.repo_dir}/${var.sub_dir}; git tag -a 1.0.0 -m 'initial release'; git push -u origin 1.0.0"
  }
}
