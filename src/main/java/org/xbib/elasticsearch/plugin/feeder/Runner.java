package org.xbib.elasticsearch.plugin.feeder;

import java.io.InputStreamReader;

/**
 * Stub for loading a class (tool) and execute it. Isolating the main method from other methods is of advantage for JVMs that thoroughly check if this class ca
 * be executed.
 */
public class Runner {

	public static void main(String[] args) {
		try {
			Class clazz = Class.forName(args[0]);
			if (args[1] != null) {
				try {
					// load given JDBC driver
					Class.forName(args[1]);
				}
				catch (Exception e) {
					System.err.println(args[1]);
					e.printStackTrace();
					System.exit(2);
				}
			}
			CommandLineInterpreter commandLineInterpreter = (CommandLineInterpreter) clazz.newInstance();
			Runtime.getRuntime().addShutdownHook(commandLineInterpreter.shutdownHook());
			commandLineInterpreter.readFrom(new InputStreamReader(System.in, "UTF-8")).run();
		}
		catch (Throwable e) {
			e.printStackTrace();
			System.exit(1);
		}
		System.exit(0);
	}
}
