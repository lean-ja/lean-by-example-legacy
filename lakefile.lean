import Lake
open Lake DSL

package «Lean by Example» where
  -- add package configuration options here
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target]
lean_lib «Src» where
  globs := #[.submodules `Src]

require mdgen from git
  "https://github.com/Seasawher/mdgen" @ "main"

def runCmd (cmd : String) (args : Array String) : ScriptM Bool := do
  let out ← IO.Process.output {
    cmd := cmd
    args := args
  }
  let hasError := out.exitCode != 0
  if hasError then
    IO.eprint out.stderr
  return hasError

script build do
  if ← runCmd "lake" #["exe", "mdgen", "Src", "md/build"] then return 1
  if ← runCmd "mdbook" #["build"] then return 1
  return 0
