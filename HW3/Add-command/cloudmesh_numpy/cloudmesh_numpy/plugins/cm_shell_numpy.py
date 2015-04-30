from __future__ import print_function
import os
from cmd3.console import Console
from cmd3.shell import command

from cloudmesh_numpy.command_numpy import command_numpy


class cm_shell_numpy:

    def activate_cm_shell_numpy(self):
        self.register_command_topic('mycommands', 'numpy')

    @command
    def do_numpy(self, args, arguments):
        """
        ::

          Usage:
              numpy NAME

          tests via ping if the host ith the give NAME is reachable

          Arguments:

            NAME      Name of the machine to test

          Options:

             -v       verbose mode

        """
        # pprint(arguments)

        if arguments["NAME"] is None:
            Console.error("Please specify a host name")
        else:
            host = arguments["NAME"]
            Console.info("trying to reach {0}".format(host))
            status = command_numpy.status(host)
            if status:
                Console.info("machine " + host + " has been found. ok.")
            else:
                Console.error("machine " + host + " not reachable. error.")
        pass

if __name__ == '__main__':
    command = cm_shell_numpy()
    command.do_numpy("iu.edu")
    command.do_numpy("iu.edu-wrong")
