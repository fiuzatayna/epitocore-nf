process DOWNLOADPSORTB{
    output:
    path 'psortb'

    script:
    """
    wget https://raw.githubusercontent.com/brinkmanlab/psortb_commandline_docker/master/psortb;
    chmod +x psortb
    """
}