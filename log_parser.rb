class LogParser
  def initialize
    @file_rows = parse_log_file(ARGV[0])
  rescue Errno::ENOENT => elad
    @file_rows = nil
  end

  def start
    return 'this is not a valid file' unless @file_rows

    unique_entries = find_unique_entries(@file_rows)
    find_pages(@file_rows)
             .map { |page_name| [page_name, select_entry_times(page_name, unique_entries)] }
             .sort { |entry, second_entry| second_entry[1] <=> entry[1] }
             .map { |entry| "#{entry[0]} #{entry[1]} unique #{pluralize_view(entry[1])}" }
             .join("\n")
  end

  private
  
  def parse_log_file(name_with_relative_path)
      array = File.readlines(name_with_relative_path, chomp: true).map { |node| node.split }
    end

    def find_unique_entries(file_rows)
      file_rows.uniq
    end

    def find_pages(file_rows)
      file_rows.map { |node| node[0] }.uniq
    end

    def select_entry_times(page, unique_file_rows)
      unique_file_rows.select { |row| row[0] == page }.length
    end

    def pluralize_view(number)
      return "view" if number == 1
      "views"
    end
end
