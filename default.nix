{ pkgs ? import <nixpkgs> {} }: 

with pkgs; 
mkShell {
    buildInputs = [
        python312
        cowsay
        git
    ]; 
}