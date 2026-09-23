#Requires -Version 5.1
<#
Sets up the enhanced Vim markdown config (Windows port) by pointing your
Vim config at this project's vimrc. Safe to re-run: it won't overwrite an
existing _vimrc without asking, and does nothing destructive without
confirmation.

Unlike the Linux setup.sh (which symlinks ~/.vimrc), this appends/creates a
plain `source` line in $HOME\_vimrc instead — symlinks on Windows need
admin rights or Developer Mode enabled, and a source line needs neither.
#>

$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VimrcSrc = Join-Path $ScriptDir 'vimrc'
$VimrcSrcForward = $VimrcSrc -replace '\\', '/'
$VimrcDest = Join-Path $HOME '_vimrc'

Write-Host "== Enhanced Vim Markdown Setup (Windows) =="

# --- Check dependencies -----------------------------------------------
$missing = @()
foreach ($cmd in 'vim', 'pandoc', 'wkhtmltopdf') {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        $missing += $cmd
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Missing required tools: $($missing -join ', ')"
    Write-Host "Install them with winget, e.g.:"
    if ($missing -contains 'vim') { Write-Host "  winget install vim.vim" }
    if ($missing -contains 'pandoc') { Write-Host "  winget install --id JohnMacFarlane.Pandoc" }
    if ($missing -contains 'wkhtmltopdf') { Write-Host "  winget install --id wkhtmltopdf.wkhtmltox" }
    Write-Host "(see vim_shortcuts.html for details; open a NEW terminal after installing so PATH updates take effect)"
    exit 1
}
Write-Host "Found: vim, pandoc, wkhtmltopdf"

# fzf is optional: everything except <leader>ff/<leader>sa works without it,
# so this warns rather than exiting.
$fzfPluginPath = Join-Path $HOME '.fzf\plugin\fzf.vim'
if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "Note: fzf not found on PATH -- <leader>ff (fuzzy find) and <leader>sa"
    Write-Host "(fuzzy save-as) won't work until it's installed:"
    Write-Host "  winget install --id junegunn.fzf"
    Write-Host "That gives you fzf.exe. Vim's :FZF command also needs fzf's bundled Vim"
    Write-Host "plugin, which the winget package does NOT include -- get it separately:"
    Write-Host "  git clone --depth 1 https://github.com/junegunn/fzf.git `"$HOME\.fzf`""
    Write-Host ""
} elseif (-not (Test-Path $fzfPluginPath)) {
    Write-Host ""
    Write-Host "Note: fzf.exe is on PATH, but its Vim plugin wasn't found at"
    Write-Host "  $fzfPluginPath"
    Write-Host "so <leader>ff/<leader>sa still won't work. Get it with:"
    Write-Host "  git clone --depth 1 https://github.com/junegunn/fzf.git `"$HOME\.fzf`""
    Write-Host ""
} else {
    Write-Host "Found: fzf (binary + Vim plugin)"
}

# --- Point _vimrc at this project's vimrc --------------------------------
$sourceLine = "source $VimrcSrcForward"

if (Test-Path $VimrcDest) {
    $existing = Get-Content $VimrcDest -Raw -ErrorAction SilentlyContinue
    if ($existing -and $existing.Contains($VimrcSrcForward)) {
        Write-Host "$VimrcDest already sources this project's vimrc -- nothing to do."
    } else {
        $backup = "$VimrcDest.bak.$(Get-Date -Format yyyyMMddHHmmss)"
        $reply = Read-Host "$VimrcDest already exists. Back it up to $backup and append this project's vimrc? [y/N]"
        if ($reply -match '^[Yy]$') {
            Copy-Item $VimrcDest $backup
            Add-Content $VimrcDest "`n$sourceLine"
            Write-Host "Backed up old config to $backup and added: $sourceLine"
        } else {
            Write-Host "Skipped. To use this config without changing your _vimrc, add this line to it yourself:"
            Write-Host "  $sourceLine"
            exit 0
        }
    }
} else {
    Set-Content -Path $VimrcDest -Value $sourceLine
    Write-Host "Created $VimrcDest with: $sourceLine"
}

Write-Host ""
Write-Host "Done. Open a markdown file to try it:"
Write-Host "  vim notes.md"
Write-Host "Leader is \  --  \p previews in browser, \e exports to PDF, \s toggles"
Write-Host "spell-check, \ff fuzzy-finds a file, \sa fuzzy-browses a save-as location."
Write-Host "Full shortcut reference: $ScriptDir\vim_shortcuts.html"
